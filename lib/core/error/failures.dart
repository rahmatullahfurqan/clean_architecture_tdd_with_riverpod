// ignore_for_file: overridden_fields
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../platform/templates.dart';

class ServerFailure extends Failure {
  @override
  final ResponseError responseError;

  const ServerFailure({required this.responseError})
      : super(responseError: responseError);
}

class ResponseError extends Equatable {
  const ResponseError({required this.statusCode, required this.error});

  final int statusCode;
  final String error;

  @override
  List<Object?> get props => [statusCode, error];
}

class CacheFailure extends Failure {
  const CacheFailure()
      : super(responseError: const ResponseError(statusCode: 0, error: ""));
}

class ClassifyError {
  static ResponseError getError(DioError e) {
    if (e.response == null) {
      return const ResponseError(
          statusCode: 10000, error: "Can't Connect to Server");
    }
    if (e.response!.statusCode == 405 && e.response!.data == null) {
      return const ResponseError(statusCode: 502, error: "Method Not Allowed");
    }
    if (e.response!.statusCode == 502 ||
        e.response!.statusCode == 522 ||
        e.response!.statusCode == 413) {
      return const ResponseError(
          statusCode: 502, error: "Something wrong here, we will fix it");
    }
    if (e.response!.statusCode == 404) {
      return ResponseError(
          statusCode: e.response!.statusCode!, error: "Page Not Found");
    }
    return ResponseError(
        statusCode: e.response!.statusCode!,
        error: e.response!.data["error"] is String
            ? e.response!.data["error"]
            : e.message);
  }
}

class ClassifyErrorPdf {
  static ResponseError getError(DioError e) {
    if (e.response == null) {
      return const ResponseError(
          statusCode: 502, error: "Can't Connect to Server");
    }
    if (e.response!.statusCode == 502 ||
        e.response!.statusCode == 522 ||
        e.response!.statusCode == 413) {
      return const ResponseError(
          statusCode: 502, error: "Something wrong here, we will fix it");
    }
    Map<String, dynamic> responseError = jsonDecode(utf8.decode(e
        .response!.data.buffer
        .asUint8List(0, e.response!.data.buffer.lengthInBytes)));
    return ResponseError(
        statusCode: e.response!.statusCode!,
        error: e.response!.statusCode == 404
            ? "Page Not Found"
            : responseError["error"] is String
                ? responseError["error"]
                : e.message);
  }
}
