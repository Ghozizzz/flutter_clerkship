import 'package:clerkship/config/themes.dart';
import 'package:clerkship/ui/screens/test_component/test_component.dart';
import 'package:clerkship/utils/nav_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive/responsive.dart';

import '../../../utils/tools.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Tools.onViewCreated(() {
      NavHelper.navigatePush(context, const TestComponent());
    });
  }

  @override
  Widget build(BuildContext context) {
    Tools.changeStatusbarIconColor(darkIcon: false);
    Responsive.setDesignSize(360, 1295);
    Responsive.initScreenSize(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return const Scaffold(
      backgroundColor: Themes.primary,
    );
  }
}
