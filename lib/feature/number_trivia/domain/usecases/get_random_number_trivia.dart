import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/platform/templates.dart';
import '../entities/number_trivia.dart';

class GetRandomNumberTrivia
    implements UseCase<NumberTrivia, GetRandomNumberTriviaParams> {
  Repository<NumberTrivia, GetRandomNumberTriviaParams> repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
      GetRandomNumberTriviaParams params) async {
    return await repository.call(params);
  }
}

class GetRandomNumberTriviaParams extends Equatable {
  const GetRandomNumberTriviaParams({
    this.context,
  });

  final BuildContext? context;

  @override
  List<Object?> get props => [];
}
