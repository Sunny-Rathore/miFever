import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/payment_screen/models/payment_model.dart';

/// A controller class for the PaymentScreen.
///
/// This class manages the state of the PaymentScreen, including the
/// current paymentModelObj
class PaymentController extends GetxController {
  Rx<PaymentModel> paymentModelObj = PaymentModel().obs;
  var selectedOption = ''.obs;
  // Rx<PaymentTwoModel> paymentTwoModelObj = PaymentTwoModel().obs;
}
