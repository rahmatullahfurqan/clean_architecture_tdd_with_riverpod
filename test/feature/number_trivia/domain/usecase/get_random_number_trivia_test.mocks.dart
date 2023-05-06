// Mocks generated by Mockito 5.4.0 from annotations
// in flutter_tdd_with_riverpod/test/feature/number_trivia/domain/usecase/get_random_number_trivia_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter_tdd_with_riverpod/core/platform/templates.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [Repository].
///
/// See the documentation for Mockito's code generation for more information.
class MockRepository<T, Params> extends _i1.Mock
    implements _i3.Repository<T, Params> {
  MockRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i3.Failure, T>> call(Params? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i4.Future<_i2.Either<_i3.Failure, T>>.value(
            _FakeEither_0<_i3.Failure, T>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i3.Failure, T>>);
}
