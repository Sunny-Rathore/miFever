import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import '../../core/utils/progress_dialog_utils.dart';

Future<void> sendMail(
    {required String email,
    required String text,
    required String subject,
    required String fullName}) async {
  String username = 'rathoreankit582@gmail.com';
  String password = 'bqkd nunq vcpf bfbz';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, fullName)
    ..recipients.add(email)
    ..subject = subject
    ..text = text;

  try {
    ProgressDialogUtils.showProgressDialog();
    final sendReport = await send(message, smtpServer);
    ProgressDialogUtils.hideProgressDialog();
    debugPrint('Message sent: ${sendReport.toString()}');
  } catch (e) {
    print('Error occurred: $e');
  }
}

int generateRandomNumber() {
  Random random = Random();
  return 1000 + random.nextInt(9000);
}
