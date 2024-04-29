// //Video Call Button
// import 'package:flutter/material.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// import '../../../core/app_export.dart';

// class VideoCallButton extends StatelessWidget {
//   const VideoCallButton({
//     required this.receiverId,
//     required this.name,
//   });

//   final String receiverId;
//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 32.v,
//       width: 32.v,
//       child: ZegoSendCallInvitationButton(
//         margin: EdgeInsets.zero,
//         padding: EdgeInsets.zero,
//         timeoutSeconds: 40,
//         iconSize: Size(32.v, 32.v),
//         onPressed: (code, message, p2) {},
//         icon: ButtonIcon(
//           icon: CustomImageView(
//             imagePath: ImageConstant.imgVideo02,
//             alignment: Alignment.center,
//           ),
//         ),
//         customData: "customData",
//         resourceID: 'MiFeverResourceId',
//         isVideoCall: true,
//         invitees: [
//           ZegoUIKitUser(
//             id: receiverId,
//             name: name,
//           ),
//         ],
//       ),
//     );
//   }
// }

// //Audio Call Button
// class AudioCallButton extends StatelessWidget {
//   const AudioCallButton({
//     required this.receiverId,
//     required this.name,
//   });
//   final String receiverId;
//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 32.v,
//       width: 32.v,
//       child: ZegoSendCallInvitationButton(
//         margin: EdgeInsets.zero,
//         padding: EdgeInsets.zero,
//         timeoutSeconds: 40,
//         iconSize: Size(32.v, 32.v),
//         icon: ButtonIcon(
//           icon: CustomImageView(
//             width: 22.v,
//             height: 22.v,
//             imagePath: ImageConstant.imgCalling,
//             alignment: Alignment.center,
//           ),
//         ),
//         onPressed: (code, message, p2) {},
//         resourceID: 'MiFeverResourceId',
//         isVideoCall: false,
//         invitees: [
//           ZegoUIKitUser(
//             id: receiverId,
//             name: name,
//           ),
//         ],
//       ),
//     );
//   }
// }
