import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/chat_three_dialog/models/chat_three_model.dart';

/// A controller class for the ChatThreeDialog.
///
/// This class manages the state of the ChatThreeDialog, including the
/// current chatThreeModelObj
class ChatThreeController extends GetxController {
  Rx<ChatThreeModel> chatThreeModelObj = ChatThreeModel().obs;
}
