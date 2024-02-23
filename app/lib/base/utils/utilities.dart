import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../common_widgets/snackbar/snackbar_content.dart';
import 'colors.dart';
import '../common_widgets/snackbar/snackbar_style.dart';

class Utilities {
  static printObj(Object message) {
    if (kDebugMode) {
      Logger.root.info(message);
      print(message);
    }
  }

  static bool isAndroid() {
    return defaultTargetPlatform == TargetPlatform.android;
  }

  static dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static showSnackBar(
      BuildContext context, String message, SnackbarStyle style) {
    if (message.isEmpty) {
      return;
    }
    _showOverlay(context, text: message, style: style);
  }

  static void _showOverlay(BuildContext context,
      {required String text, required SnackbarStyle style}) async {
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: 10,
        right: 10,
        bottom: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: SnackBarContent(message: text, style: style),
          ),
        ),
      );
    });
    // inserting overlay entry
    overlayState.insert(overlayEntry);
    await Future.delayed(const Duration(seconds: 2))
        // removing overlay entry after stipulated time.
        .whenComplete(() => overlayEntry.remove());
  }

  static showBottomSheet(
      {required Widget widget, required BuildContext context}) {
    showModalBottomSheet(
        backgroundColor: AppColors.transparent,
        barrierColor: AppColors.bottomsheetBarrierColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) => widget);
  }

  static String generateRadomCode(int digitCount) {
    Random random = Random();
    int code = random.nextInt(900000) + 100000;
    return code.toString();
  }

  static bool hasAppUpdate(
      {required String existingVersion, required String remoteVersion}) {
    var existingVersionChunks =
        existingVersion.split(".").map((e) => int.parse(e)).toList();
    var remoteVersionChunks =
        remoteVersion.split(".").map((e) => int.parse(e)).toList();
    if ((existingVersionChunks.length != 3) ||
        (remoteVersionChunks.length != 3)) {
      return false;
    }
    if (remoteVersionChunks[0] > existingVersionChunks[0]) {
      return true;
    } else if (remoteVersionChunks[0] == existingVersionChunks[0]) {
      if (remoteVersionChunks[1] > existingVersionChunks[1]) {
        return true;
      } else if (remoteVersionChunks[1] == existingVersionChunks[1]) {
        if (remoteVersionChunks[2] > existingVersionChunks[2]) {
          return true;
        }
      }
    }
    return false;
  }
}
