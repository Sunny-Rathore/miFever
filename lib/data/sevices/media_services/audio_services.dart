import 'dart:async';
import 'dart:developer';

import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/app_export.dart';

class VoiceRecorderController extends GetxController {
  VoiceRecorderController() {
    Get.put(VoiceRecorderController());
  }
  //static final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  static final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();

  static var isRecording = RxBool(false);

  static var isPlaying = RxBool(false);

  static RxString recordingPath = ''.obs;

  static RxInt audioPosition = 0.obs;

  static RxInt audioDuration = 0.obs;

  static final player = AudioPlayer();

//Record Audio

  static Future<void> startRecording() async {
    PermissionStatus status = await Permission.microphone.request();
    final appDir = await getApplicationDocumentsDirectory();
    final recordingPath = '${appDir.path}/my_recording.aac';
    if (status.isGranted) {
      try {
        isRecording(true);
        await _audioRecorder.openRecorder();
        await _audioRecorder.startRecorder(
          toFile: recordingPath,
        );
      } catch (e) {
        log('Voice Recorder Error', error: 'Error: $e');
      }
    } else if (status.isDenied) {
      // openAppSettings();
      // Permission has been denied.
      // You can inform the user about the need for this permission.
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      // Permission has been permanently denied.
      // You can inform the user and provide instructions on how to enable the permission in app settings.
    }
  }

  static Future<String> stopRecording() async {
    isRecording(false);
    try {
      final appDir = await getApplicationDocumentsDirectory();
      recordingPath.value = '${appDir.path}/my_recording.aac';

      await _audioRecorder.openRecorder();
      String path = await _audioRecorder.stopRecorder() ?? '';
      print(path);
    } catch (e) {
      log('voice recorder Stopping error ', error: e.toString());
    }
    await _audioRecorder.closeRecorder();
    return recordingPath.value;
  }

  //Play Audio
  static Future<void> playAudio(String recordingPath) async {
    //final appDir = await getApplicationDocumentsDirectory();
    //final recordingPath = '${appDir.path}/my_recording.aac';
    try {
      // final player = AudioPlayer();
      await player.setUrl(// Load a URL
          recordingPath);
      await player.play();
      await player.setVolume(1.0);
      isPlaying(true);
    } catch (e) {
      log('Error playing audio:', error: e.toString());
    }
  }

  static Future<void> stopAudio() async {
    try {
      await player.stop();
      // await _audioPlayer.stopPlayer();
    } catch (e) {
      log('Error stopping recording: ', error: e.toString());
    }
    isPlaying(false);
  }
}
