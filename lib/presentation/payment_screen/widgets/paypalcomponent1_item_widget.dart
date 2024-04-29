import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/payment_controller.dart';
import '../models/paymentoptions_item_model.dart';

// ignore: must_be_immutable
class Paypalcomponent1ItemWidget extends StatelessWidget {
  Paypalcomponent1ItemWidget(
    this.paypalcomponent1ItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  PaymentoptionsItemModel paypalcomponent1ItemModelObj;

  var controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 11.v,
      ),
      decoration: AppDecoration.outlineRedA2001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => CustomImageView(
              imagePath: paypalcomponent1ItemModelObj.paypalImage!.value,
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
                paypalcomponent1ItemModelObj.paypalText!.value,
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
          Spacer(),
          Obx(
            () => CustomImageView(
              imagePath: paypalcomponent1ItemModelObj.paypalImage!.value,
              height: 20.adaptSize,
              width: 20.adaptSize,
              margin: EdgeInsets.symmetric(vertical: 5.v),
            ),
          ),
        ],
      ),
    );
  }
}
