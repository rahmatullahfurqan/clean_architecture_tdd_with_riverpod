import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_with_riverpod/core/platform/templates.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

class RepositoryImpl<T, Params> implements Repository<T, Params> {
  final RemoteDataSource<T, Params> remoteDataSource;
  final Network networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, T>> call(Params params) async =>
      await _call(() => remoteDataSource.call(params));

  Future<Either<Failure, T>> _call(
    Future<T> Function() call,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await call();
        return Right(response);
      } on ServerException catch (_) {
        return Left(ServerFailure(responseError: _.responseError));
      }
    } else {
      return const Left(
        ServerFailure(
          responseError: ResponseError(
            error: "No Internet Connection",
            statusCode: 500,
          ),
        ),
      );
    }
  }
}

class NetworkImpl implements Network {
  @override
  Future<bool> get isConnected async =>
      await InternetConnectionChecker().hasConnection;
}
