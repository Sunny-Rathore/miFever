import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';

import '../controller/edit_personal_details_controller.dart';
import '../models/profliedetailseditpersonaldeta_item_model.dart';

// ignore: must_be_immutable
class ProfliedetailseditpersonaldetaItemWidget extends StatelessWidget {
  ProfliedetailseditpersonaldetaItemWidget(
    this.profliedetailseditpersonaldetaItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  ProfliedetailseditpersonaldetaItemModel
      profliedetailseditpersonaldetaItemModelObj;

  var controller = Get.find<EditPersonalDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.selectedGender.value =
              profliedetailseditpersonaldetaItemModelObj.title?.value ?? 'Male';
        },
        child: Row(
          children: [
            Radio(
                value: controller.selectedGender.value ==
                    profliedetailseditpersonaldetaItemModelObj.title?.value,
                groupValue: true,
                onChanged: (val) {
                  controller.selectedGender.value =
                      profliedetailseditpersonaldetaItemModelObj.title?.value ??
                          'Male';
                }),
            Text(
              profliedetailseditpersonaldetaItemModelObj.title?.value ??
                  "lbl_gender".tr,
              style: CustomTextStyles.titleSmallGray60004,
            ),
          ],
        ),
      ),
    );
  }
}
