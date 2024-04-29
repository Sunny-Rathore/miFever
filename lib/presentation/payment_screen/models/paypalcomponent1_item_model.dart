import 'package:mifever/presentation/payment_screen/models/paymentoptions_item_model.dart';

import '../../../core/app_export.dart';

/// This class defines the variables used in the [payment_two_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PaymentTwoModel {
  Rx<List<PaymentoptionsItemModel>> paymentoptionsItemList = Rx([
    PaymentoptionsItemModel(
        paypalImage: ImageConstant.imgImage1601.obs,
        paypalText: "Paypal".obs,
        gcashImage: ImageConstant.imgImage1600.obs,
        gcashText: "Gcash".obs,
        creditDebitImage: ImageConstant.imgCreditCardOnprimary.obs,
        creditDebitText: "Creditcard/Debitcard".obs,
        creditDebitCheckmarkImage: ImageConstant.imgCheckmark.obs)
  ]);
}
