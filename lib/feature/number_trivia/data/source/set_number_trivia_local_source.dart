// import 'dart:convert';
// import 'package:flutter_tdd_with_riverpod/feature/number_trivia/data/models/number_trivia_model.dart';
// import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/entities/number_trivia.dart';
// import 'package:flutter_tdd_with_riverpod/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
// import 'package:hive_flutter/adapters.dart';
// import '../../../../core/platform/templates.dart';

// class SetNumberTriviaLocalSource
//     implements LocalDataSource<NumberTrivia, GetRandomNumberTriviaParams> {
//   SetNumberTriviaLocalSource();

//   @override
//   Future<String> call(GetRandomNumberTriviaParams params) async {
//     late Box box1;
//     await Hive.initFlutter();
//     box1 = await Hive.openBox('homeV2');
//     box1.put('cached_home', jsonEncode(params.toJson()));
//     print({"runtime ": "update number trivia ke cached"});
//     return "Succses";
//   }

// }
