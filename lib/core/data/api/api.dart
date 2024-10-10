import 'package:dio/dio.dart';
import 'package:project/features/layout/todo_app_cubit.dart';

class Api {
  String baseUrl = 'https://todo.iraqsapp.com/';
  Future getHttp(context, {authToken, url}) async {
    try {
      var response = await Dio().get(baseUrl + url,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var productsList = response.data;
        return productsList;
      } else {
        return '';
      }
    } on DioError catch (e) {
      print(e.response!.data['message'].toString());
      print(e.response!.statusCode);
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future getHttpWithoutToken(context, {url}) async {
    try {
      var response = await Dio().get(baseUrl + url, options: Options());
      if (response.statusCode == 200 || response.statusCode == 201) {
        var productsList = response.data;
        return productsList;
      } else {
        return '';
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future<dynamic> postHttp(context,
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data,
          queryParameters: queryParams,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
            },
          ));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future<dynamic> postHttpRegister(context,
      {required url, data, authToken, queryParams}) async {
    try {
      var response = await Dio().post('$baseUrl$url',
          data: data, queryParameters: queryParams, options: Options());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future<dynamic> putHttp(context,
      {required url, required data, authToken}) async {
    try {
      var response = await Dio().patch('$baseUrl$url',
          data: data,
          options: Options(headers: {
            "Authorization": 'Bearer $authToken',
          }));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }

  Future<dynamic> deleteHttp(context, {required url, data, authToken}) async {
    try {
      var response = await Dio().delete(baseUrl + url,
          data: data,
          options: Options(
            headers: {
              "Authorization": 'Bearer $authToken',
            },
          ));
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      if (e.response!.data['message'].toString() == 'Unauthorized' ||
          e.response!.statusCode == 401) {
        TodoAppCubit.get(context).reFreshToken(context);
      } else {
        throw Exception(e.response!.data);
      }
    }
  }
}
