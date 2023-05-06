import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../error/failures.dart';

abstract class Failure extends Equatable {
  final ResponseError responseError;

  const Failure({required this.responseError});

  @override
  List<Object> get props => [responseError];
}

abstract class Params extends Equatable {
  final BuildContext context;

  const Params({required this.context});

  @override
  List<Object> get props => [context];
}

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class RemoteDataSource<T, Params> {
  Future<T> call(Params params);
}

abstract class LocalDataSource<T, Params> {
  Future<T> set(Params params);
  Future<T> get(Params params);
}

abstract class Repository<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class Network {
  Future<bool> get isConnected;
}
