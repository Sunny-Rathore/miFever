import 'package:mifever/core/app_export.dart';import 'package:mifever/presentation/delete_chat_screen/models/delete_chat_model.dart';/// A controller class for the DeleteChatScreen.
///
/// This class manages the state of the DeleteChatScreen, including the
/// current deleteChatModelObj
class DeleteChatController extends GetxController {Rx<DeleteChatModel> deleteChatModelObj = DeleteChatModel().obs;

 }
