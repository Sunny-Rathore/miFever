import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/create_new_password_one_dialog/models/create_new_password_one_model.dart';

/// A controller class for the CreateNewPasswordOneDialog.
///
/// This class manages the state of the CreateNewPasswordOneDialog, including the
/// current createNewPasswordOneModelObj
class CreateNewPasswordOneController extends GetxController {
  Rx<CreateNewPasswordOneModel> createNewPasswordOneModelObj =
      CreateNewPasswordOneModel().obs;
}
