import '../../../core/app_export.dart';

/// This class is used in the [paymentoptions_item_widget] screen.
class PaymentoptionsItemModel {
  PaymentoptionsItemModel({
    this.paypalImage,
    this.paypalText,
    this.gcashImage,
    this.gcashText,
    this.creditDebitImage,
    this.creditDebitText,
    this.creditDebitCheckmarkImage,
    this.id,
  }) {
    paypalImage = paypalImage ?? Rx(ImageConstant.imgImage1601);
    paypalText = paypalText ?? Rx("Paypal");
    gcashImage = gcashImage ?? Rx(ImageConstant.imgImage1600);
    gcashText = gcashText ?? Rx("Gcash");
    creditDebitImage =
        creditDebitImage ?? Rx(ImageConstant.imgCreditCardOnprimary);
    creditDebitText = creditDebitText ?? Rx("Creditcard/Debitcard");
    creditDebitCheckmarkImage =
        creditDebitCheckmarkImage ?? Rx(ImageConstant.imgCheckmark);
    id = id ?? Rx("");
  }

  Rx<String>? paypalImage;

  Rx<String>? paypalText;

  Rx<String>? gcashImage;

  Rx<String>? gcashText;

  Rx<String>? creditDebitImage;

  Rx<String>? creditDebitText;

  Rx<String>? creditDebitCheckmarkImage;

  Rx<String>? id;
}
