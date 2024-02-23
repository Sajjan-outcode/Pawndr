import 'package:alice/alice.dart';
import 'package:alice/core/alice_dio_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ApiLogService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final Alice _alice;
  ApiLogService() {
    if (!kReleaseMode) {
      _alice = Alice(navigatorKey: _navigatorKey, showInspectorOnShake: true);
    }
  }

  GlobalKey<NavigatorState>? get navigationKey => _navigatorKey;
  AliceDioInterceptor get aliceInterceptor => _alice.getDioInterceptor();

  showLog() {
    _alice.showInspector();
  }
}
