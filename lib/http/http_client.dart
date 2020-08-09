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
      dio.transformer = ATransformer();
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

  Options processHeaderAndOption(
      Options oldOptions, Map header, ResponseType responseType) {
    Options options = oldOptions;

    ///Options
    if (null == options) {
      options = new Options();
      options.responseType =
          responseType == null ? ResponseType.plain : responseType;
    }
    if (header != null) {
      if (options.headers == null) {
        options.headers = new Map();
      }
      options.headers.addAll(header);
    }
    return options;
  }

  Future get(url, {params, header, Options option, responseType}) async {
    Options options = processHeaderAndOption(option, header, responseType);
    options.method = GET;

    return request(url, options: options, queryParameters: params);
  }

  Future post(url, {params, header, option, data, responseType}) async {
    Options options = processHeaderAndOption(option, header, responseType);
    options.method = POST;
    return request(url, options: options, queryParameters: params, data: data);
  }

  Future postMultipartForm(url,
      {data, params, header, option, responseType}) async {
    Options options = processHeaderAndOption(option, header, responseType);
    options.contentType = "multipart/form-data";

    return dio.post(url, data: data, options: options);
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
