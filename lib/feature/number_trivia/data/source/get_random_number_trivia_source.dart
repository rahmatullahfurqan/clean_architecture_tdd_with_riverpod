import 'package:dio/dio.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/templates.dart';
import '../../../../core/provider/dio.dart';

class GetRandomNumberTriviaSource
    implements
        RemoteDataSource<NumberTriviaModel, GetRandomNumberTriviaParams> {
  final DioState dio;

  GetRandomNumberTriviaSource({required this.dio});

  @override
  Future<NumberTriviaModel> call(GetRandomNumberTriviaParams params) async {
    try {
      final response = await dio.value.get(
        "/random",
      );
      return NumberTriviaModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerException(responseError: ClassifyError.getError(e));
    }
  }
}
