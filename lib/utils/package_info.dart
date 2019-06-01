import 'dart:async';
import 'package:package_info/package_info.dart';

Future<PackageInfo> getPackageInfo() async {
  final PackageInfo info = await PackageInfo.fromPlatform();

  if (info == null) {
    return PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
    );
  } else {
    return info;
  }
}

Map<String, Object> packageInfoToJson(PackageInfo PackageInfo) {
  return {
    "appName": PackageInfo.appName,
    "packageName": PackageInfo.packageName,
    "version": PackageInfo.version,
    "buildNumber": PackageInfo.buildNumber,
  };
}

String packageInfoToString(PackageInfo packageInfo) {
  return "appName:" + packageInfo.appName + "packageName: " + packageInfo.packageName + "version: " + packageInfo.version + "buildNumber: " + packageInfo.buildNumber;
}
