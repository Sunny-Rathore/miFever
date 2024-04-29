import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/widgets/app_bar/appbar_leading_image.dart';
import 'package:mifever/widgets/app_bar/appbar_subtitle.dart';
import 'package:mifever/widgets/app_bar/custom_app_bar.dart';
import 'package:mifever/widgets/custom_elevated_button.dart';

import 'controller/payment_controller.dart';
import 'models/paymentoptions_item_model.dart';
import 'widgets/paymentoptions_item_widget.dart';

// ignore_for_file: must_be_immutable
class PaymentScreen extends GetWidget<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 20.v),
              _buildPaymentOptions(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 11.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Number'),
                    SizedBox(height: 8.h),
                    _textFromField(hint: 'XXXXXXXXXX'),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Exp. Date'),
                            SizedBox(height: 8.h),
                            _textFromField(hint: 'MM/YYY'),
                          ],
                        )),
                        SizedBox(width: 20.v),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CVV'),
                            SizedBox(height: 8.h),
                            _textFromField(hint: '***'),
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildContinue(),
      ),
    );
  }

  TextFormField _textFromField({
    required String hint,
  }) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          constraints: BoxConstraints(maxHeight: 50.h),
          contentPadding:
              EdgeInsets.only(top: 13.v, right: 13.h, bottom: 13.v, left: 10.v),
          hintStyle: CustomTextStyles.bodySmall12,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appTheme.redA200,
              width: 1.h,
            ),
            borderRadius: BorderRadiusStyle.roundedBorder4,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: appTheme.gray200,
              width: 1.h,
            ),
            borderRadius: BorderRadiusStyle.roundedBorder4,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: appTheme.gray200,
              width: 1.h,
            ),
            borderRadius: BorderRadiusStyle.roundedBorder4,
          )),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        onTap: () {
          Get.back();
        },
        imagePath: ImageConstant.imgArrowLeft02SharpGray90024x24,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.v,
          bottom: 16.v,
        ),
      ),
      title: AppbarSubtitle(
        text: "lbl_payment".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildPaymentOptions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Obx(
        () => ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              height: 11.v,
            );
          },
          itemCount: controller
              .paymentModelObj.value.paymentoptionsItemList.value.length,
          itemBuilder: (context, index) {
            PaymentoptionsItemModel model = controller
                .paymentModelObj.value.paymentoptionsItemList.value[index];
            return PaymentoptionsItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContinue() {
    return CustomElevatedButton(
      text: "lbl_continue".tr,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 40.v,
      ),
      rightIcon: Container(
        margin: EdgeInsets.only(left: 4.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowleft02sharp,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      onPressed: () {},
    );
  }
}
