// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/core/utils/progress_dialog_utils.dart';
import 'package:mifever/data/models/user/user_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/data/sevices/smtp_service.dart';
import 'package:mifever/presentation/my_profile_screen/models/frame7_item_model.dart';

import '../../presentation/subscription_plans_page/models/subscription_plans_model.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../models/subscriptions/subscription_model.dart';
import '../models/text_tries_model/text_tries_model.dart';

class StripePaymentHandle {
  static String PUBLISHABLE_KEY =
      'pk_test_51FBglhJKDGfJmqFFVYCmWXYNO8jDhImWDOlMlE827r8CygQoj1r7vnGx8frYSi1oLNQp7VKx7W6b3L9ahnooqpMx00aaLwF8jf';
  static String STRIPE_SECRET = 'sk_test_ydpPmFCuJt0BUYCrp9X6AIAE005opzYN8x';
  static Map<String, dynamic>? paymentIntent;
  static SubscriptionModel? subscriptionModel;
  static Future<void> stripeMakePayment(SubscriptionModel model) async {
    subscriptionModel = model;
    try {
      ProgressDialogUtils.showProgressDialog();
      paymentIntent = await createPaymentIntent('100', 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  allowsDelayedPaymentMethods: true,
                  customFlow: true,
                  billingDetails: BillingDetails(
                      name: 'Name',
                      email: 'YOUREMAIL@gmail.com',
                      phone: 'YOUR NUMBER',
                      address: Address(
                          city: 'YOUR CITY',
                          country: 'YOUR COUNTRY',
                          line1: 'YOUR ADDRESS 1',
                          line2: 'YOUR ADDRESS 2',
                          postalCode: 'YOUR PINCODE',
                          state: 'YOUR STATE')),
                  googlePay: const PaymentSheetGooglePay(
                      amount: '100',
                      // Currency and country code is according to India
                      testEnv: true,
                      currencyCode: "INR",
                      merchantCountryCode: "IN"),
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  merchantDisplayName: 'Ikay'))
          .then((value) {});
      ProgressDialogUtils.hideProgressDialog();
      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static displayPaymentSheet() async {
    try {
      // 3.display the payment sheet.
      final result = await Stripe.instance.presentPaymentSheet();
      print(subscriptionModel!.userId);
      print(subscriptionModel!.plan.id!.value);

      if (subscriptionModel!.plan.id!.value == PlanType.TextTries.name) {
        TextTriesModel textTriesModel = TextTriesModel(
            userId: PrefUtils.getId(),
            timestamp: DateTime.now().toString(),
            chances: subscriptionModel!.plan.duration!.value);
        await FirebaseServices.addTextTriesSubscription(textTriesModel);
        //confirmation email
        UserModel? user = await FirebaseServices.getCurrentUser();
        await sendMail(
            fullName: PrefUtils.getUserName(),
            subject: 'Text Tries Purchased Successfully!',
            email: user!.email!,
            text:
                'Dear ${PrefUtils.getUserName()},\n\nThank you for selecting the Text Tries feature. With this feature, you can now engage in conversations with MiFever users without the need for a match.You have successfully purchased ${subscriptionModel?.plan.duration?.value} Text Tries for ${subscriptionModel?.plan.amount?.value}.\nThank you for entrusting us with your communication needs.\n\n\nWarm regards,\nMiFever Team');
        Get.off(() => CustomBottomBar());
      } else {
        await FirebaseServices.addSubscription(subscriptionModel!);
        //confirmation email
        List featureList = [];
        if (subscriptionModel?.plan.id?.value == PlanType.Gold.name) {
          var index = 1;
          SubscriptionPlansModel().plansFeatureListGold.value.map((e) {
            if (e.isEnable?.value ?? false) {
              featureList.add("$index. ${e.title?.value}");
              index++;
            }
          }).toList();
        } else {
          var index = 1;
          SubscriptionPlansModel().plansFeatureListPlatinum.value.map((e) {
            if (e.isEnable?.value ?? false) {
              featureList.add("$index. ${e.title?.value}");
              index++;
            }
          }).toList();
        }
        UserModel? user = await FirebaseServices.getCurrentUser();
        await sendMail(
            subject:
                'Confirmation of ${subscriptionModel?.plan.id?.value} Plan Purchase',
            fullName: PrefUtils.getUserName(),
            email: user!.email!,
            text:
                'Dear ${PrefUtils.getUserName()},\nWe are pleased to inform you that your purchase of the ${subscriptionModel?.plan.id?.value}} Plan has been successfully processed. With this feature, you will gain access to a range of exclusive benefits tailored to enhance your experience on our platform.\n\nFeatures Included in the Plan:\n${featureList.join("\n")}\n\nShould you have any inquiries or require assistance, please feel free to reach out to our dedicated support team at support@mifever.com\n\n\nWarm regards,\nMiFever Team');
        print("result: $result");
        UserModel updateUser =
            UserModel(planName: subscriptionModel!.plan.id!.value);
        FirebaseServices.updateUser(updateUser);
        Fluttertoast.showToast(msg: 'Payment successfully completed');
        final bottomBarController = Get.find<CustomBottomBarController>();
        bottomBarController.selectedIndex.value = 3;
        Get.off(() => CustomBottomBar());
      }
    } catch (e) {
      print('Error:$e');
      if (e is StripeException) {
        Fluttertoast.showToast(msg: 'Payment Failed');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: $e');
      }
    }
  }

//create Payment
  static createPaymentIntent(String amount, String currency) async {
    var _dio = Dio();
    try {
      //Request body
      Map<String, dynamic> data = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };
      //Make post request to Stripe
      var response = await _dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $STRIPE_SECRET',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: data,
      );
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  static calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
