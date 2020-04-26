import 'dart:collection';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/http/ATransformer.dart';
import 'package:flutter_base/log/logger.dart';

import 'http_response.dart';

class HttpClient {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static HttpClient get instance => _getInstance();
  static HttpClient _instance;
  Dio dio;

  HttpClient._init() {
    if (dio == null) {
      dio = new Dio();
      //dio.interceptors.add(HttpLogInterceptor());

      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        // config the http client
        //client.findProxy = (uri) {
        //  //proxy all request to localhost:8888
        //  return "192.168.1.1:8888";
        //};
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          Logger.d("host:$host port:$port");
          return true;
        };
        // you can also create a new HttpClient to dio
        // return new HttpClient();
      };
      dio.transformer=ATransformer();
    }
  }

  addInterceptor(Interceptor interceptor) {
    dio.interceptors.add(interceptor);
  }

  clearInterceptor() {
    dio.interceptors.clear();
  }

  static HttpClient _getInstance() {
    if (_instance == null) {
      _instance = new HttpClient._init();
    }
    return _instance;
  }

  Future get(url, {params, header, Options option, responseType}) async {
    Options options = option;

    ///Options
    if (null == options) {
      options = new Options();
      options.responseType =
          responseType == null ? ResponseType.plain : responseType;
    }
    if (header != null) {
      if (options.headers == null) {
        options.headers = new HashMap();
      }
      options.headers.addAll(header);
    }
    options.method = GET;

    //Response response;
    //response = await dio.get("/test", options: option);
    //print(response.data.toString());
    return request(url, options: options, queryParameters: params);
  }

  Future post(url, {params, header, option, data, responseType}) async {
    Options options = option;

    ///Options
    if (null == options) {
      options = new Options();
      options.responseType =
          responseType == null ? ResponseType.plain : responseType;
    }
    if (header != null) {
      if (options.headers == null) {
        options.headers = new HashMap();
      }
      options.headers.addAll(header);
    }
    option.method = POST;
    return request(url, options: option, queryParameters: params, data: data);
  }

  Future postForm(url, {formData, params, header}) async {
    //FormData formData = new FormData.from({
    //  "name": "wendux",
    //  "age": 25,
    //  //"file1": new UploadFileInfo(new File("./upload.txt"), "upload1.txt")
    //  //"file2": new UploadFileInfo(new File("./upload.txt"), "upload2.txt")
    //});

    return dio.request(url, data: formData);
  }

  Future<HttpResponse> request(url, {options, queryParameters, data}) async {
    Response response;

    ///dio request
    try {
      response = await dio.request(url,
          options: options, queryParameters: queryParameters, data: data);
    } on DioError catch (e) {
      Logger.d("response error $e");
      Logger.d(
          "response error params:$queryParameters, headers:${options.headers}");
      Response errorResponse = e.response ?? Response();
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = 503;
      }
      return HttpResponse(e.message, e.message, errorResponse.statusCode,
          isSuccess: false);
    } catch (e) {
      Logger.d("response error2 $e");
    }

    ///result
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpResponse(response.data, "ok", response.statusCode,
            isSuccess: true);
      }
    } catch (e) {
      Logger.d("params:$queryParameters, headers:${options.headers}");
      Logger.d("net error:${e.toString()}");
      return HttpResponse(e.toString(), e.toString(), response.statusCode,
          isSuccess: false);
    }

    Logger.d("some error:");
    return HttpResponse("net work error", "", response.statusCode,
        isSuccess: false);
  }
}
