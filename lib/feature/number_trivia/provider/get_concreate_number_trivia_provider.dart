import 'package:flutter_tdd_with_riverpod/core/provider/network.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/source/number_trivia_local_source.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/provider/number_trivia_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../core/error/messages.dart';
import '../../../core/platform/sources.dart';
import '../../../core/platform/templates.dart';
import '../../../core/provider/dio.dart';
import '../data/source/get_concreate_number_trivia_source.dart';
import '../domain/usecases/get_concreate_number_trivia.dart';

final getConcreateNumberTriviaProvider = Provider.autoDispose.family(
  (ref, GetConcreateNumberTriviaParams params) async {
    final response = await GetConcreateNumberTrivia(
      RepositoryImpl(
        remoteDataSource: ref.watch(
          Provider.autoDispose<
              RemoteDataSource<NumberTrivia, GetConcreateNumberTriviaParams>>(
            (ref) => GetConcreateNumberTriviaSource(
              dio: ref.watch(dioProvider),
            ),
          ),
        ),
        localDataSource: ref.watch(
          Provider.autoDispose<
              LocalDataSource<NumberTrivia, NumberTriviaModel>>(
            (ref) => SetNumberTriviaLocalSource(),
          ),
        ),
        networkInfo: ref.watch(networkProvider),
      ),
    ).call(params).then((value) => value);
    return response.fold((l) {
      ErrorMessageNotification.handler(params.context!, l.responseError);
      ref.read(currentNumberTriviaProvider.notifier).setNumberTrivia(
          const NumberTriviaState(
              loading: false,
              trivia: NumberTriviaModel(text: "Kosong", number: 0)));
    },
        (r) => ref
            .read(currentNumberTriviaProvider.notifier)
            .setNumberTrivia(NumberTriviaState(loading: false, trivia: r)));
  },
);
