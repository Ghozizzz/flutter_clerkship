import 'package:clerkship/config/constant.dart';
import 'package:clerkship/main.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/entity/check_version_response.dart';
import '../network/services/version_service.dart';

class VersionProvider extends ChangeNotifier {
  final versionService = getIt<VersionService>();
  SharedPreferences? prefs;
  String? currentVersion;
  CheckVersionResponse? checkVersionResponse;

  void resetVersion() {
    currentVersion = null;
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<void> saveVersion(String version) async {
    currentVersion = version;
    if (prefs != null) {
      await prefs!.setString(Constant.version, version);
      notifyListeners();
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs!.setString(Constant.version, version);
      notifyListeners();
    }
  }

  Future<String?> loadVersion() async {
    prefs ??= await SharedPreferences.getInstance();
    currentVersion = prefs?.getString(Constant.version);
    notifyListeners();
    return currentVersion;
  }

  Future<CheckVersionResponse?> checkVersion() async {
    try {
      final appVersion = await getAppVersion();
      final result = await versionService.checkVersion(version: appVersion);

      if (result.statusCode == 200) {
        checkVersionResponse = result.data;
        notifyListeners();
        return checkVersionResponse;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('Error checking version: $e');
      return null;
    }
  }
}
