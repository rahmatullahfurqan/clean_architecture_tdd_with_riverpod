import 'package:dio/dio.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/templates.dart';
import '../../../../core/provider/dio.dart';
import '../../domain/usecases/get_concreate_number_trivia.dart';

class GetConcreateNumberTriviaSource
    implements
        RemoteDataSource<NumberTriviaModel, GetConcreateNumberTriviaParams> {
  final DioState dio;

  GetConcreateNumberTriviaSource({required this.dio});

  @override
  Future<NumberTriviaModel> call(GetConcreateNumberTriviaParams params) async {
    try {
      final response = await dio.value.get(
        "/${params.number}",
      );
      return NumberTriviaModel.fromJson(response.data);
    } on DioError catch (e) {
      throw ServerException(responseError: ClassifyError.getError(e));
    }
  }
}
