import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

import 'custom/in_app_notification_view.dart';
import 'in_app_notification.dart';

class InAppNotificationOverlay {
  final String id;
  late final OverlayEntry overlay;

  InAppNotificationOverlay({
    required this.id,
  });
}

class InAppNotificationHandler {
  final List<InAppNotificationOverlay> _overlays = [];
  static final InAppNotificationHandler _instance =
      InAppNotificationHandler._internal();
  factory InAppNotificationHandler() {
    return _instance;
  }

  InAppNotificationHandler._internal();

  void showOverlay(BuildContext context,
      {required InAppNotification notification}) async {
    OverlayState? overlayState = Overlay.of(context);
    final overlay = InAppNotificationOverlay(id: const Uuid().v4());
    OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return InAppNotificationContent(
        overlay: overlay,
        notification: notification,
        onCloseClicked: (currentOverlay) {
          _removeOverlay(currentOverlay);
        },
        onNotificationClicked: (currentOverlay, notification) {
          _removeOverlay(currentOverlay);
          // Injector.instance<DashboardBloc>().add(InAppNotificationReceivedEvent(
          //     notification, NotificationAppState.onClick));
        },
      );
    });
    overlay.overlay = overlayEntry;
    _overlays.add(overlay);
    _vibrate();
    overlayState.insert(overlayEntry);
  }

  _removeOverlay(InAppNotificationOverlay overlay) {
    overlay.overlay.remove();
    _overlays.removeWhere((element) => element.id == overlay.id);
  }

  _vibrate() async {
    bool hasVibration = (await Vibration.hasVibrator()) ?? false;
    if (hasVibration) {
      Vibration.vibrate();
    }
  }
}
