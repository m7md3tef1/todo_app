import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import '../../const/utils.dart';
import '../../dialoges/toast.dart';
import '../../keys/keys.dart';
import '../../router/router.dart';
import '../local/cacheHelper.dart';

class Api {
  String baseUrl = 'https://self-labsite.zauzat.com/api/';
  Future getHttp({authToken, url}) async {
    try {
      var response = await Dio().get(baseUrl + url,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        var productsList = response.data;
        // print(productsList);
        return productsList;
      } else {
        return '';
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'You Are Not Authorized') {
        token = '';
        token = CacheHelper.putString(SharedKeys.token, '');
      }
      if (e.response!.statusCode == 401) {
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future getDataHttp({authToken, url}) async {
    try {
      var response = await Dio().get(baseUrl + url,
          options: Options(
            headers: {
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        var productsList = response.data;
        return productsList;
      } else {
        return '';
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'You Are Not Authorized') {
        token = '';
        token = CacheHelper.putString(SharedKeys.token, '');
      }
      if (e.response!.statusCode == 401) {
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future getHttpCache({authToken, url}) async {
    try {
      Dio dio = Dio();
      DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
      Options myOptions = buildCacheOptions(const Duration(days: 30),
          forceRefresh: true,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      dio.interceptors.add(dioCacheManager.interceptor);

      var response = await Dio().get(
        baseUrl + url,
        options: myOptions,
      );
      if (response.statusCode == 200) {
        var productsList = response.data;
        return productsList;
      } else {
        return '';
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future<dynamic> postHttpLogin(
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));

      if (response.statusCode == 200) {
        CacheHelper.putBool(SharedKeys.isLogin, true);
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.data.toString().contains('needActive')) {
        showToast(
            msg: 'Your Account Is Not Active',
            state: ToastedStates.WARNING);
        // MagicRouter.navigateAndPopAll(
        //     OtpScreen(e.response!.data['errors']['email'], isLogin: true));
      } else {
        showToast(
            msg: 'Email Or Password Is Not True',
            state: ToastedStates.WARNING);
      }
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postHttp({required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {}
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postDataHttp(
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {}
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postHttp1({required url, authToken}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postHttp2(
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              'Accept': 'application/json',
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {}
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postHttp4(
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              'Accept': 'application/json',
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {}
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> postHttp3(
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              'Accept': 'application/json',
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      var error = e.response!.data['errors']
          .toString()
          .replaceAll('{password:', '')
          .replaceAll('[', '')
          .replaceAll(']}', '')
          .replaceAll('{username:', '')
          .replaceAll('{email:', '');
      showToast(msg: error, state: ToastedStates.SUCCESS);
      throw Exception(e.response!.data);
    }
  }

  Future<dynamic> putHttp({required url, required data, authToken}) async {
    try {
      var response = await Dio().patch('$baseUrl$url',
          data: data,
          options: Options(headers: {
            "Authorization": 'Bearer $authToken',
            // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
            //             .currentLocale ==
            //         const Locale('ar', '')
            //     ? 'ar'
            //     : "en"
          }));
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {}
  }

  Future<dynamic> deleteHttp({required url, data, authToken}) async {
    try {
      var response = await Dio().delete(baseUrl + url,
          data: data,
          options: Options(
            headers: {
              'Accept': 'application/json',
              "Authorization": 'Bearer $authToken',
              // "lang": EasyLocalization.of(navigatorKey.currentContext!)!
              //             .currentLocale ==
              //         const Locale('ar', '')
              //     ? 'ar'
              //     : "en"
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {}
  }
}

String baseUrl = 'https://self-labsite.zauzat.com/api/';

class APIRequest {
  static const String _baseUrl = 'https://self-labsite.zauzat.com/api/';
  DioError? _dioError;
  Dio? _dio;
  @protected
  Dio get dio => _dio!;
  @protected
  DioError get dioError => _dioError!;
  APIRequest() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: 600000,
      receiveTimeout: 500000,
    ));
    _dio!.interceptors
        .add(DioCacheManager(CacheConfig(baseUrl: _baseUrl)).interceptor);
    _dio!.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers = {
        "Accept": 'application/json',
        "Authorization": 'Bearer $token',
        // "lang":
        //     EasyLocalization.of(navigatorKey.currentContext!)!.currentLocale ==
        //             const Locale('ar', '')
        //         ? 'ar'
        //         : "en"
      };
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (error, handler) {
      _dioError = error;
      return handler.next(error);
    }));
  }

  Future<dynamic> getPost(Map<String, dynamic>? params, String get,
      {bool forceRefresh = true}) async {
    try {
      Response x = await _dio!.get(get,
          queryParameters: params,
          options: buildCacheOptions(const Duration(days: 7),
              maxStale: const Duration(days: 10), forceRefresh: forceRefresh));
      if (x.statusCode == 200) {
        return x.data;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
      } else {
        throw Exception(e.response!.data);
      }
    }
  }
}
