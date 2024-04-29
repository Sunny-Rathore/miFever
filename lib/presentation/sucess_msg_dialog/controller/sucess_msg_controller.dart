import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/sucess_msg_dialog/models/sucess_msg_model.dart';

/// A controller class for the SucessMsgDialog.
///
/// This class manages the state of the SucessMsgDialog, including the
/// current sucessMsgModelObj
class SucessMsgController extends GetxController {
  Rx<SucessMsgModel> sucessMsgModelObj = SucessMsgModel().obs;
}
