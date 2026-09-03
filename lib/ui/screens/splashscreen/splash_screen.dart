import 'package:clerkship/data/shared_providers/notification_provider.dart';
import 'package:clerkship/data/shared_providers/user_provider.dart';
import 'package:clerkship/data/shared_providers/version_provider.dart';
import 'package:clerkship/ui/screens/dashboard/dashboard_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_store/open_store.dart';
import 'package:provider/provider.dart';
import 'package:responsive/responsive.dart';
import 'package:widget_helper/widget_helper.dart';

import '../../../config/themes.dart';
import '../../../data/shared_providers/auth_provider.dart';
import '../../../injection.dart';
import '../../../r.dart';
import '../../../utils/nav_helper.dart';
import '../../../utils/tools.dart';
import '../dashboard_lecture/dashboard_lecture_screen.dart';
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
    injectService();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;

      final versionResponse =
          await context.read<VersionProvider>().checkVersion();

      if (!mounted) return;

      if (versionResponse != null &&
          versionResponse.error == false &&
          versionResponse.data != null) {
        final needsUpdate = versionResponse.data!.hasUpdate == true;
        if (needsUpdate) {
          _showUpdateDialog();
        } else {
          checkLogin();
        }
      } else {
        checkLogin();
      }
    } catch (e) {
      checkLogin();
    }
  }

  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Update Required'),
        content: const Text(
            'A new version of the app is available. Please update to continue.'),
        actions: [
          TextButton(
            onPressed: () {
              OpenStore.instance.open(
                androidAppBundleId: 'edu.uph.clerkship',
                appStoreId: '6448694321',
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void checkLogin() {
    Tools.onViewCreated(() {
      Future.delayed(const Duration(seconds: 1), () async {
        final isLogged = await context.read<AuthProvider>().isLogged();
        if (isLogged) {
          getCurrentUser();
        } else {
          NavHelper.navigateReplace(LoginScreen());
        }
      });
    });
  }

  void getCurrentUser() {
    context.read<UserProvider>().getCurrentUser().then((value) {
      int? role = context.read<UserProvider>().user.roleId;
      if (role == null) {
        // /myaccount failed (expired session, server down/blocked, bad
        // response, etc.) — bounce to Login instead of crashing on a null
        // role.
        NavHelper.navigateReplace(LoginScreen());
        return;
      }
      if (role == 1) {
        context.read<NotificationProvider>().getNotification(role: role);
        NavHelper.navigateReplace(
          const DashboardLectureScreen(),
        );
      } else {
        context.read<NotificationProvider>().getNotification(role: role);
        NavHelper.navigateReplace(
          const DashboardStudentScreen(),
        );
      }
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
