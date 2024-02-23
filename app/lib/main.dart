import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/http_overrides.dart';
import 'injector/injector.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'main_app.dart';
import 'services/console_log_stream.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp();

  Injector.init();
  await Injector.instance.allReady();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MainApp()),
  );
}
