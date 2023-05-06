import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/platform/templates.dart';
import '../entities/number_trivia.dart';

class GetConcreateNumberTrivia
    implements UseCase<NumberTrivia, GetConcreateNumberTriviaParams> {
  Repository<NumberTrivia, GetConcreateNumberTriviaParams> repository;

  GetConcreateNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(
      GetConcreateNumberTriviaParams params) async {
    return await repository.call(params);
  }
}

class GetConcreateNumberTriviaParams extends Equatable {
  const GetConcreateNumberTriviaParams({
    this.context,
    required this.number,
  });

  final BuildContext? context;
  final int number;

  @override
  List<Object?> get props => [number];
}
