import 'package:app/features/login/bloc/login_bloc.dart';

import '../features/authentication/bloc/authentication_bloc.dart';
import '../features/device_management/bloc/device_management_bloc.dart';
import '../features/firebase_dynamic_link_handler/bloc/firebase_dynamic_link_handler_bloc.dart';
import '../features/others/about_app_screen/app_information_view/bloc/app_version_info_view_bloc.dart';
import 'injector.dart';

class BlocModule {
  BlocModule._();

  static void init() {
    final injector = Injector.instance;

    injector.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(
        authenticationRepository: injector(), userRepository: injector()));

    _initializeTertiaryBloc();

    injector.registerFactory(() => LoginBloc(
        authenticationRepository: injector(), logService: injector()));
  }

  static _initializeTertiaryBloc() {
    final injector = Injector.instance;
    injector.registerLazySingleton<DeviceManagementBloc>(() {
      final DeviceManagementBloc bloc = DeviceManagementBloc(
          deviceRepository: injector(),
          pushNotificationService: injector(),
          deviceInformationRetrievalService: injector(),
          analyticsService: null,
          userRepository: injector(),
          pushNotificationRepository: injector());
      return bloc;
    });

    injector.registerLazySingleton<FirebaseDynamicLinkBloc>(() {
      final FirebaseDynamicLinkBloc bloc = FirebaseDynamicLinkBloc(
          userRepository: injector(),
          firebaseDynamicLinkService: injector(),
          analyticsService: injector());
      return bloc;
    });

    injector.registerLazySingleton<AppVersionInfoViewBloc>(() {
      final AppVersionInfoViewBloc bloc = AppVersionInfoViewBloc(
          deviceInformationRetrievalService: injector(),
          deviceRepository: injector());
      return bloc;
    });
  }
}
