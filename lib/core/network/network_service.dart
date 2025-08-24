import 'dart:convert';
import 'dart:io';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:what_s_up_app/core/cache/preferences_storage/preferences_storage.dart';
import '../../generated/l10n.dart';
import '../cache/secure_storage/secure_storage.dart';
import '/core/constants/strings.dart';
import '/core/di/services_locator.dart';
import '/core/env.dart';
import '/core/error/failure.dart';
import '/core/network/endpoints.dart';
import 'authorization_interceptor.dart';

class NetworkService {
  final Dio dio;

  NetworkService(this.dio) {
    dio.options
      ..baseUrl = AppStrings.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60);

    addHeaders();
    addInterceptors();
  }

  void addInterceptors() {
    dio.interceptors.add(AuthorizationInterceptor());
    if (isDevEnvironment()) {
      dio.interceptors.add(ChuckerDioInterceptor());
      dio.interceptors.add(
        PrettyDioLogger(requestBody: true, requestHeader: true),
      );
    }
  }

  void addHeaders() async {
    final token = await sl<SecureStorage>().read(SecureStorageKeys.userToken);
    dio.options.headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "locale": sl<PreferencesStorage>().getCurrentLanguage(),
    };
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  String extractMessage(dynamic data) {
    if (data is Map) {
      return data['message'] ??
          data['msg'] ??
          data['error'] ??
          data['errorMessage'] ??
          S().somethingWentWrong;
    }
    return S().somethingWentWrong;
  }

  Future<Either<Failure, dynamic>> _safeRequest(
    Future<Response> Function() requestFn,
  ) async {
    if (!await _hasInternetConnection()) {
      return Left(Failure(S().noInternet));
    }
    try {
      final response = await requestFn();
      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        if (response.data is Map && response.data['status'] == false) {
          final message = extractMessage(response.data);
          return Left(Failure(message));
        }
        return Right(response.data);
      } else {
        final message = extractMessage(response.data);
        return Left(Failure(message));
      }
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(Failure(message));
    } catch (_) {
      return Left(Failure(S().somethingWentWrong));
    }
  }

  Future<Either<Failure, dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () => dio.get(endPoint, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> postData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isRaw = true,
  }) async {
    final payload =
        data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data);
    return _safeRequest(
      () => dio.post(endPoint, data: payload, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> putData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () => dio.put(endPoint, data: data, queryParameters: queryParameters),
    );
  }

  Future<Either<String, dynamic>> patchData({
    required String endPoint,
    required FormData data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.patch(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Future<Either<String, dynamic>> deleteData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response.data);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Future<Either<Failure, dynamic>> postEncryptedData({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isRaw = true,
  }) async {
    final jsonPayload = jsonEncode(data);
    final signature = hmacSha256(jsonPayload);
    final encodedSignature = base64.encode(utf8.encode(signature));
    dio.options.headers['X-Signature'] = encodedSignature;

    final payload =
        data == null
            ? null
            : isRaw
            ? data
            : FormData.fromMap(data);
    return _safeRequest(
      () => dio.post(endPoint, data: payload, queryParameters: queryParameters),
    );
  }

  Future<Either<Failure, dynamic>> uploadFile({
    required String endPoint,
    required FormData formData,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _safeRequest(
      () =>
          dio.post(endPoint, data: formData, queryParameters: queryParameters),
    );
  }

  Future<Either<String, dynamic>> downloadFile({
    required String fileUrl,
    required String savePath,
    Map<String, dynamic>? queryParameters,
  }) async {
    if (!await _hasInternetConnection()) {
      return Left(S().noInternet);
    }
    try {
      final response = await dio.download(
        fileUrl,
        savePath,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      final message = extractMessage(e.response?.data);
      return Left(message);
    } catch (_) {
      return Left(S().somethingWentWrong);
    }
  }

  Left<Failure, dynamic> handleDioExceoptions(DioException e) {
    final message = extractMessage(e.response?.data);
    return Left(Failure(message));
  }

  String hmacSha256(String data) {
    final hmac = Hmac(sha256, utf8.encode(EndPoints.apiSecret));
    return hmac.convert(utf8.encode(data)).toString();
  }
}
