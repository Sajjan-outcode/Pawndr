import 'package:app/base/common_widgets/image_widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import '../base/utils/images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.transparent,
      child: AppImageView(
          initialsText: "App",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width),
    ));
  }
}
