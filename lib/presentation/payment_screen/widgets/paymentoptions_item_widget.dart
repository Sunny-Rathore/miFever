import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/payment_controller.dart';
import '../models/paymentoptions_item_model.dart';

// ignore: must_be_immutable
class PaymentoptionsItemWidget extends StatelessWidget {
  PaymentoptionsItemWidget(
    this.paymentoptionsItemModelObj, {
    Key? key,
  }) : super(key: key);

  PaymentoptionsItemModel paymentoptionsItemModelObj;

  var controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            //controller.selectedOption.value =paymentoptionsItemModelObj.
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.h,
              vertical: 11.v,
            ),
            decoration: AppDecoration.outlineGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => CustomImageView(
                    imagePath: paymentoptionsItemModelObj.paypalImage!.value,
                    height: 30.adaptSize,
                    width: 30.adaptSize,
                    radius: BorderRadius.circular(
                      4.h,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8.h,
                    top: 6.v,
                    bottom: 3.v,
                  ),
                  child: Obx(
                    () => Text(
                      paymentoptionsItemModelObj.paypalText!.value,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 5.v),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.h,
                    ),
                    border: Border.all(
                      color: appTheme.gray200,
                      width: 1.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 11.v,
          ),
          decoration: AppDecoration.outlineGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustomImageView(
                  imagePath: paymentoptionsItemModelObj.gcashImage!.value,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  radius: BorderRadius.circular(
                    4.h,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 4.v,
                  bottom: 5.v,
                ),
                child: Obx(
                  () => Text(
                    paymentoptionsItemModelObj.gcashText!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              Spacer(),
              Container(
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 5.v),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.h,
                  ),
                  border: Border.all(
                    color: appTheme.gray200,
                    width: 1.h,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 11.v,
          ),
          decoration:
              // AppDecoration.outlineGray.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder4,
              // ),
              AppDecoration.outlineRedA2001.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CustomImageView(
                  imagePath: paymentoptionsItemModelObj.creditDebitImage!.value,
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.h,
                  top: 4.v,
                  bottom: 5.v,
                ),
                child: Obx(
                  () => Text(
                    paymentoptionsItemModelObj.creditDebitText!.value,
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
              Spacer(),
              Obx(
                () => CustomImageView(
                  imagePath: paymentoptionsItemModelObj
                      .creditDebitCheckmarkImage!.value,
                  height: 20.adaptSize,
                  width: 20.adaptSize,
                  margin: EdgeInsets.symmetric(vertical: 5.v),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
