import 'dart:convert';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../core/platform/templates.dart';

class SetNumberTriviaLocalSource
    implements LocalDataSource<NumberTrivia, NumberTriviaModel> {
  SetNumberTriviaLocalSource();

  @override
  Future<NumberTrivia> set(NumberTriviaModel params) async {
    late Box box1;
    await Hive.initFlutter();
    box1 = await Hive.openBox('number_trivia');
    box1.put('number_trivia_cache', jsonEncode(params.toJson()));
    return params;
  }

  @override
  Future<NumberTrivia> get(NumberTriviaModel params) async {
    late Box box1;
    await Hive.initFlutter();
    box1 = await Hive.openBox('number_trivia');
    final response = box1.get(
      'number_trivia_cache',
    );
    return NumberTriviaModel.fromJson(jsonDecode(response));
  }
}
