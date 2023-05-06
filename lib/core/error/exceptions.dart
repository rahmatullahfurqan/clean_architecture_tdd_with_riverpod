import "failures.dart";

class ServerException implements Exception {
  final ResponseError responseError;
  ServerException({
    this.responseError = const ResponseError(statusCode: 0, error: ""),
  });
}
