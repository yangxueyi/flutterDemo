import 'package:dio/dio.dart';

import '../constans/AppConstants.dart';
import 'AppInfoUtils.dart';
import 'DeviceInfoUtils.dart';

class HttpUtil {
  static void get(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    // 数据拼接
    if (data != null && data.isNotEmpty) {
      StringBuffer options = new StringBuffer('?');
      data.forEach((key, value) {
        options.write('${key}=${value}&');
      });
      String optionsStr = options.toString();
      optionsStr = optionsStr.substring(0, optionsStr.length - 1);
      url += optionsStr;
    }

    // 发送get请求
    _sendRequest(url, 'get', success, headers: headers, error: error);
  }

  static Future post(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    // 发送post请求
    Future<Response> sendRequest = _sendRequest(url, 'post', success,
        data: data, headers: headers, error: error);
    return sendRequest;
  }

  // 请求处理
  static Future<Response> _sendRequest(
      String url, String method, Function success,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error}) async {
    String _code;
    String _msg;
    var _backData;

    // 检测请求地址是否是完整地址
//    if (!url.startsWith('http')) {
////      url = BaseUrl.url + url;
////    }

    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;

      //默认参数
      Map<String, String> paras = {
        "appStore": "jjy100001",
        "appVersion": AppInfoUtils.getInstance().getAppVersion(),
        "deviceId": DeviceInfoUtils.getInstance().getDeviceId(),
        "deviceSystem": "ANDROID",
        "deviceType": DeviceInfoUtils.getInstance().getDiviceType(),
      };
      dataMap.addAll(paras);

      BaseOptions options = BaseOptions(
          method: method,
          baseUrl: AppConstans.BaseUrl,
          connectTimeout: 20000,
          receiveTimeout: 20000,
          headers: headersMap);

      // 配置dio请求信息
      Response response;
      Dio dio = new Dio(options);

      if (method == 'get') {
        response = await dio.get(url);
      } else {
        response = await dio.post(url, data: dataMap);
      }

      if (response.statusCode != 200) {
        _msg = '网络请求错误,状态码:' + response.statusCode.toString();
        _handError(error, _msg);
      }

      // 返回结果处理
      Map<String, dynamic> resCallbackMap = response.data;
      _code = resCallbackMap['resultCode'];
      _msg = resCallbackMap['resultCodeMsg'];
      _backData =
          new Map<String, dynamic>.from(resCallbackMap['businessObject']);

      if (success != null) {
        if (_code == 'C03000000') {
          success(_backData);
        } else {
          print(_code + "**************");
          String errorMsg = _code + ':' + _msg;
          _handError(error, errorMsg);
        }
      }
      return response;
    } catch (exception) {
      _handError(error, '数据请求错误：' + exception.toString());
//      print(_code+"/////====/////" + exception.toString());

    }
  }

  // 返回错误信息
  static Future _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}
