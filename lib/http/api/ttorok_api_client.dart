/*
 * "ttorok" created by @howyoujini on 2/11/24  4:22 PM
 * Copyright (c) . All rights reserved.
 */

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ttorok/utils/json_serializable.dart' as ttorok;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract interface class TtorokApiHttpClient {
  void bearerAuthentication(final String token);

  Future<Map<String, dynamic>> get(final String url);

  Future<Map<String, dynamic>> post(final String url, {final ttorok.JsonSerializable? payload});

  Future<Map<String, dynamic>> postFormData(String url, FormData formData);

  Future<Map<String, dynamic>> patch(final String url, {final ttorok.JsonSerializable? payload});

  Future<Map<String, dynamic>> put(final String url, {final ttorok.JsonSerializable? payload});

  Future<Map<String, dynamic>> delete(final String url, {final ttorok.JsonSerializable? payload});
}

class HttpClientDioImpl implements TtorokApiHttpClient {
  static String baseUrl = dotenv.env['BASE_URL']!;
  Dio? _dio;

  static BaseOptions options = BaseOptions(
    baseUrl: "$baseUrl/",
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    validateStatus: (_) => true,
  );

  Dio get _client => _dio ??= Dio(options);

  @override
  void bearerAuthentication(final String token) {
    final headers = {'Cookie': token};
    _client.options.headers.addAll(headers);
  }

  @override
  Future<Map<String, dynamic>> get(final String url) {
    return _toHttpResponse(_client.get(url));
  }

  @override
  Future<Map<String, dynamic>> post(String url, {payload}) {
    final Future<Response<Map<String, dynamic>>> response;
    if (payload == null) {
      response = _client.post(url);
    } else {
      response = _client.post(url, data: payload.toJson());
    }
    return _toHttpResponse(response);
  }

  @override
  Future<Map<String, dynamic>> postFormData(String url, FormData formData) {
    _client.options.contentType = 'multipart/form-data';

    return _toHttpResponse(_client.post(url, data: formData));
  }

  @override
  Future<Map<String, dynamic>> patch(String url, {payload}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> put(String url, {payload}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> delete(String url, {payload}) {
    return _toHttpResponse(_client.delete(url));
  }

  Future<Map<String, dynamic>> _toHttpResponse(
      final Future<Response<Map<String, dynamic>>> dioResponse) async {
    Map<String, dynamic> parseResponse(final Response<dynamic> it) {
      final statusCode = it.statusCode;
      if (statusCode == null) {
        throw const HttpException("No http status code from peer");
      } else if (statusCode == ErrorCode.UNAUTHORIZED_ERROR.code) {
        throw LoginRequiredException();
      }

      return it.data;
    }

    try {
      final Response it = await dioResponse;
      return parseResponse(it);
    } on DioException catch (e) {
      final response = e.response;
      if (response == null) {
        throw const HttpException("Empty response body from host");
      } else {
        return parseResponse(response);
      }
    } on LoginRequiredException {
      rethrow;
    } catch (e) {
      throw const HttpException("Connection refused");
    }
  }
}

enum ErrorCode {
  UNAUTHORIZED_ERROR(401),
  FORBIDDEN_ERROR(403),
  NOT_FOUND_ERROR(404),
  INTERNAL_SERVER_ERROR(500),
  BAD_GATEWAY_ERROR(502),
  SERVICE_UNAVAILABLE_ERROR(503);

  final int code;

  const ErrorCode(this.code);
}

class LoginRequiredException implements HttpException {
  @override
  String get message => "Login required";

  @override
  Uri? get uri => null;
}
