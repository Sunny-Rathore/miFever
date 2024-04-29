import 'package:get/get.dart';

import '../../subscription_plans_page/models/subscription_plans_model.dart';
import '../controller/subscription_plans_controller.dart';

class SubscriptionPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => SubscriptionPlansController(SubscriptionPlansModel().obs));
  }
}
