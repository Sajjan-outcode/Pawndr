import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/device_management/bloc/device_management_bloc.dart';
import 'features/login/login.dart';
import 'features/others/about_app_screen/app_information_view/bloc/app_version_info_view_bloc.dart';
import 'features/splash_screen.dart';
import 'injector/injector.dart';
import 'services/api_log_service.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _navigatorKey = Injector.instance<ApiLogService>().navigationKey;
  NavigatorState? get _navigator => _navigatorKey?.currentState;
  late final AuthenticationBloc _bloc;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _bloc = Injector.instance<AuthenticationBloc>();
    _bloc.add(AuthenticationCheckUserSessionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>.value(
          value: _bloc,
        ),
        BlocProvider<DeviceManagementBloc>.value(
            value: Injector.instance<DeviceManagementBloc>()),
        BlocProvider<AppVersionInfoViewBloc>.value(
            value: Injector.instance<AppVersionInfoViewBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Lato',
          splashColor: Colors.transparent,
        ),
        navigatorKey: _navigatorKey,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is AuthenticationAuthenticatedState) {
                // navigate to your dashboard
                // _navigator?.pushAndRemoveUntil(
                //     UserDashboardScreen.route(), (route) => false);
              } else if (state is AuthenticationUnauthenticatedState) {
                _navigator?.pushAndRemoveUntil(
                    LoginScreen.route(), (route) => false);
              } else if (state is AuthenticationTokenExistState) {
                // navigate to your dashboard
                // _navigator?.pushAndRemoveUntil(
                //     UserDashboardScreen.route(), (route) => false);
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (settings) => SplashPage.route(),
      ),
    );
  }
}
