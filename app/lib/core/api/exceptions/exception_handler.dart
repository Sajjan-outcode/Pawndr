import 'dart:io';
import 'package:dio/dio.dart';
import 'custom_exception.dart';

class ExceptionHandler {
  ExceptionHandler._();

  static CustomException handleException(Object obj) {
    if (obj is DioError) {
      return _getException(obj);
    } else if (obj is CustomException) {
      return obj;
    }
    return CustomException.error("Error");
  }

  static CustomException _getException(DioError error) {
    if (error.type == DioErrorType.other) {
      if (error.error is SocketException) {
        return CustomException.noInternetConnection();
      } else {
        return CustomException.error("Something went wrong");
      }
    } else if (error.type == DioErrorType.response) {
      try {
        if (error.response!.statusCode == 401) {
          return CustomException.sessionExpired();
        } else if (error.response!.statusCode == 400 &&
            error.requestOptions.path.contains("login")) {
          return CustomException.error("Please check your login credentials");
        } else if (error.response!.statusCode == 422 &&
            error.requestOptions.path.contains("forgot-password")) {
          return CustomException.error(
              "If there is any account with such email address, we have sent you a password retreival email. Please check");
        } else {
          return fromJson(error.response!.data);
        }
      } catch (e) {
        return CustomException.error(e.toString());
      }
    } else if (error.type == DioErrorType.sendTimeout) {
      return CustomException.timeoutExpection();
    } else {
      return CustomException.error(error.message);
    }
  }

  static CustomException fromJson(Map<String, dynamic> json) {
    var keys = json.keys;
    List<String> messages = [];
    for (var element in keys) {
      if (json[element] is String) {
        messages.add(json[element]);
      }
    }
    return CustomException.error(messages.join("\n"));
  }
}
