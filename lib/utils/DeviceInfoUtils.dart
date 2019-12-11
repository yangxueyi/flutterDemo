import 'package:device_info/device_info.dart';

class DeviceInfoUtils {
  static final DeviceInfoUtils deviceInfoUtils = DeviceInfoUtils.init();

  static DeviceInfoPlugin deviceInfoPlugin;

  AndroidDeviceInfo androidInfo;

  static DeviceInfoUtils getInstance() {
    return deviceInfoUtils;
  }

  DeviceInfoUtils.init() {
    deviceInfoPlugin = DeviceInfoPlugin();
    getDeviceInfo();
  }

  //获取androidInfo
  getDeviceInfo() async {
      androidInfo = await deviceInfoPlugin.androidInfo;
  }

  String getDiviceType()  {
    String phoneName =  getPhoneName();
    String phoneModel =  getPhoneModel();
    String version = getVersion();
    return phoneName + " " + phoneModel + " Android " + version;
  }

  //手机名称
  String getPhoneName()  {
    var brand = androidInfo.brand;
    return brand;
  }

  //手机型号
  String getPhoneModel() {
    var model = androidInfo.model;
    return model;
  }

  //android 版本
  String getVersion() {
    String version = androidInfo.version.release;
    return version;
  }

  //sdk版本
  String getSdkVersion(){
    String version = androidInfo.version.sdkInt.toString();
    return version;
  }

  //获取设备id
  String getDeviceId(){
    return androidInfo.androidId;
  }



}
