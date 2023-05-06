import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../platform/sources.dart';
import '../platform/templates.dart';

final networkProvider = Provider<Network>(
  (ref) => NetworkImpl(),
);
