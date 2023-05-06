import 'package:dartz/dartz.dart';
import 'package:flutter_tdd_with_riverpod/core/platform/templates.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_random_number_trivia_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late GetRandomNumberTrivia usecase;
  late NumberTrivia response;
  late MockRepository<NumberTrivia, GetRandomNumberTriviaParams> mockRepository;
  setUp(() {
    mockRepository = MockRepository();
    usecase = GetRandomNumberTrivia(mockRepository);
    response = const NumberTriviaModel(number: 1, text: "");
  });

  test(
    'should get number trivia from the repository',
    () async {
      // arrange
      when(mockRepository.call(const GetRandomNumberTriviaParams()))
          .thenAnswer((_) async => Right(response));
      // act
      final result = await usecase(const GetRandomNumberTriviaParams());
      // assert
      expect(result, equals(Right(response)));
      verify(mockRepository.call(const GetRandomNumberTriviaParams()));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
