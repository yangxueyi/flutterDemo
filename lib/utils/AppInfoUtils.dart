import 'package:package_info/package_info.dart';

class AppInfoUtils {
  static final AppInfoUtils appInfoUtils = AppInfoUtils.init();
  static PackageInfo packageInfo;

  static AppInfoUtils getInstance(){
    return appInfoUtils;
  }

  AppInfoUtils.init() {
    getPackageInfo();
  }

  //获取packageInfo
  getPackageInfo() async {
      packageInfo = await PackageInfo.fromPlatform();
  }

  //获取appVersion
   String getAppVersion() {
    return packageInfo.version;
  }

  //获取app名称
  String getAppName() {
    return packageInfo.appName;
  }
}
