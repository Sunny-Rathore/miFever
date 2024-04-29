import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/data/models/travel_plan/travel_plan_model.dart';
import 'package:mifever/data/sevices/firebase_services.dart';
import 'package:mifever/presentation/create_travel_plan_screen/controller/create_travel_plan_controller.dart';

import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../widgets/travel_user_list.dart';

class TravelPlanScreen extends StatelessWidget {
  TravelPlanScreen({Key? key}) : super(key: key);
  final controller = Get.put(CreateTravelPlanController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseServices.getTravelPlan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox.shrink();
            }
            var data = snapshot.data!.docs;
            List<TravelPlanModel> _plans = <TravelPlanModel>[];
            _plans.cast();
            _plans = data.map((e) {
              var data = e.data() as Map<String, dynamic>;
              data['docId'] = e.id;
              return TravelPlanModel.fromJson(data);
            }).toList();
            return _plans.length == 0
                ? _noTrips()
                : ListView.builder(
                    padding: EdgeInsets.all(20.h),
                    itemCount: _plans.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.only(
                            left: 10.v, bottom: 20.h, right: 10.v),
                        decoration: AppDecoration.outlineGray,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _plans[index].planName!,
                                  style: CustomTextStyles.titleMediumBlack900,
                                ),
                                Row(
                                  children: [
                                    PopupMenuButton(
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                              value: 'EDIT',
                                              child: Text('Edit')),
                                          PopupMenuItem(
                                              value: _plans[index].isActive!
                                                  ? 'INACTIVE'
                                                  : 'ACTIVE',
                                              child: Text(
                                                  _plans[index].isActive!
                                                      ? 'Inactive'
                                                      : 'Active')),
                                          PopupMenuItem(
                                              value: 'DELETE',
                                              child: Text('Delete')),
                                        ];
                                      },
                                      onSelected: (val) {
                                        if (val == 'EDIT') {
                                          onEdit(_plans[index]);
                                        } else if (val == 'INACTIVE') {
                                          onInActive(_plans[index]);
                                        } else if (val == 'ACTIVE') {
                                          onActive(_plans[index]);
                                        } else if (val == 'DELETE') {
                                          onDelete(_plans[index]);
                                        }
                                      },
                                    ),
                                    Visibility(
                                      visible: _plans[index].isActive!,
                                      child: CustomImageView(
                                        onTap: () {
                                          Get.to(() => TravelPlanUserList(
                                                planModel: _plans[index],
                                              ));
                                        },
                                        imagePath: 'assets/images/message.svg',
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgCalendar03,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize,
                                ),
                                SizedBox(width: 8.v),
                                Text(
                                    '${DateTime.parse(_plans[index].startDate!).format()} ${DateTime.parse(_plans[index].endDate!).format()}')
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgLocation01RedA200,
                                  height: 24.adaptSize,
                                  width: 24.adaptSize,
                                ),
                                SizedBox(width: 8.v),
                                Expanded(child: Text(_plans[index].location!)),
                              ],
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      );
                    },
                  );
          }),
      bottomNavigationBar: _buildCreate(),
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
        text: "msg_create_travel_plan".tr,
        margin: EdgeInsets.only(left: 12.h),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildCreate() {
    return CustomElevatedButton(
      text: "lbl_create".tr,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 36.v,
      ),
      rightIcon: Container(
        margin: EdgeInsets.only(left: 4.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgArrowleft02sharp,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      onPressed: () {
        Get.toNamed(AppRoutes.createTravelPlanScreen);
      },
    );
  }

  Widget _noTrips() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CustomImageView(
            imagePath: 'assets/images/no_trip.svg',
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Center(
              child: Text(
            'lbl_create_an_itinerary'.tr,
            textAlign: TextAlign.center,
          )),
        ),
        SizedBox(height: 16.h),
        // _buildCreate()
      ],
    );
  }

  void onEdit(TravelPlanModel plan) {
    controller.nameController.text = plan.planName!;
    controller.startDate.value = DateTime.parse(plan.startDate!);
    controller.endDate.value = DateTime.parse(plan.endDate!);
    controller.countryController.text = plan.location!;
    controller.locationLatLong.value = plan.latLng!;
    controller.docId.value = plan.docId!;
    print(plan.docId);
    Get.toNamed(AppRoutes.createTravelPlanScreen);
  }

  void onInActive(TravelPlanModel plan) async {
    TravelPlanModel travelPlanModel = TravelPlanModel(isActive: false);
    await FirebaseServices.updateTravelPlan(
        travelPlanModel: travelPlanModel, docId: plan.docId!);
  }

  void onActive(TravelPlanModel plan) async {
    TravelPlanModel travelPlanModel = TravelPlanModel(isActive: true);
    await FirebaseServices.updateTravelPlan(
        travelPlanModel: travelPlanModel, docId: plan.docId!);
  }

  void onDelete(TravelPlanModel plan) async {
    await FirebaseServices.deleteTravelPlan(docId: plan.docId!);
  }
}
