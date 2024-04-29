import '../../../core/app_export.dart';
import 'paymentoptions_item_model.dart';

/// This class defines the variables used in the [payment_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class PaymentModel {
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
  // Rx<List<Paypalcomponent1ItemModel>> paypalcomponent1ItemList = Rx([
  //   Paypalcomponent1ItemModel(
  //       paypalImage: ImageConstant.imgImage1601.obs,
  //       paypalText: "Paypal".obs,
  //       paypalCheckmark: ImageConstant.imgCheckmark.obs),
  //   Paypalcomponent1ItemModel(
  //       paypalImage: ImageConstant.imgImage1600.obs, paypalText: "Gcash".obs),
  //   Paypalcomponent1ItemModel(
  //       paypalImage: ImageConstant.imgCreditCardOnprimary.obs,
  //       paypalText: "Creditcard/Debitcard".obs)
  // ]);
}
