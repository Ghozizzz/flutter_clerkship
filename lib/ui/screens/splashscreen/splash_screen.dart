import 'package:clerkship/data/network/services/clinic_activity_service.dart';
import 'package:clerkship/data/network/services/reference_service.dart';
import 'package:clerkship/data/network/services/user_service.dart';
import 'package:clerkship/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/network/services/auth_service.dart';
import '../../../data/shared_providers/auth_provider.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../../utils/tools.dart';
import '../dashboard/student_dashboard_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getIt.registerSingleton<AuthService>(AuthService());
    getIt.registerSingleton<ReferenceService>(ReferenceService());
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<ClinicActivityService>(ClinicActivityService());

    Tools.onViewCreated(() {
      Future.delayed(const Duration(seconds: 1), () async {
        final isLogged = await context.read<AuthProvider>().isLogged();
        if (isLogged) {
          NavHelper.navigateReplace(const StudentDashboardScreen());
        } else {
          NavHelper.navigateReplace(LoginScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    NavHelper.initNavHelper(context);
    Tools.changeStatusbarIconColor(darkIcon: false);
    Responsive.setDesignSize(360, 1295);
    Responsive.initScreenSize(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      backgroundColor: Themes.primary,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                AssetImages.logo,
                width: 166.w,
              ),
            ),
            Container(
              width: 42.w,
              height: 3,
              color: Themes.white,
            ),
            Text(
              'LOG BOOK',
              style: Themes().whiteBold16?.copyWith(letterSpacing: 3),
            ).addMarginOnly(
              top: 17.h,
              bottom: 8.h,
            ),
            Text(
              'FACULTY OF MEDICINE',
              style: Themes().white12?.copyWith(letterSpacing: 3),
            ).addMarginBottom(40.h),
          ],
        ),
      ),
    );
  }
}
