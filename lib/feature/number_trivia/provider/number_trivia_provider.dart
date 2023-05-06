import 'package:equatable/equatable.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/error/messages.dart';
import '../../../core/platform/sources.dart';
import '../../../core/platform/templates.dart';
import '../../../core/provider/dio.dart';
import '../../../core/provider/network.dart';
import '../data/source/get_random_number_trivia_source.dart';
import '../domain/usecases/get_random_number_trivia.dart';

final getInitialNumberTriviaProvider = Provider.autoDispose.family(
  (ref, GetRandomNumberTriviaParams params) async {
    final response = await GetRandomNumberTrivia(
      RepositoryImpl(
        remoteDataSource: ref.watch(
          Provider.autoDispose<
              RemoteDataSource<NumberTrivia, GetRandomNumberTriviaParams>>(
            (ref) => GetRandomNumberTriviaSource(
              dio: ref.watch(dioProvider),
            ),
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

final currentNumberTriviaProvider = StateNotifierProvider.autoDispose<
    CurrentNumberTriviaNotifier, NumberTriviaState>(
  (ref) => CurrentNumberTriviaNotifier(
    const NumberTriviaState(
      loading: true,
    ),
  ),
);

class CurrentNumberTriviaNotifier extends StateNotifier<NumberTriviaState> {
  CurrentNumberTriviaNotifier(super.create);

  void setNumberTrivia(NumberTriviaState numberTriviaState) {
    state = numberTriviaState;
  }
}

//product state
class NumberTriviaState extends Equatable {
  final String error;
  final bool loading;
  final NumberTrivia trivia;

  const NumberTriviaState(
      {this.error = "",
      this.loading = false,
      this.trivia = const NumberTriviaModel(number: 0, text: "Kosong")});

  @override
  List<Object?> get props => [error, loading, trivia];
}
