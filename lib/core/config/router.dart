import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: depend_on_referenced_packages
import 'package:logging/logging.dart';

import '../../feature/number_trivia/presentation/screens/number_trivia_page.dart';

class RouterPath {
  final String path, name;
  RouterPath.create({required this.path, required this.name});
  static RouterPath home = RouterPath.create(
    path: '/home',
    name: "Home",
  );
}

final routerProvider = Provider.family(
  (ref, BuildContext context) {
    return GoRouter(
      initialLocation: RouterPath.home.path,
      observers: [MyNavObserver()],
      errorBuilder: (context, state) => const NumberTrivaPage(),
      errorPageBuilder: (context, state) {
        return FadeTransitionPage(
          child: const NumberTrivaPage(),
          key: state.pageKey,
          name: RouterPath.home.name,
        );
      },
      routes: <GoRoute>[
        GoRoute(
          path: RouterPath.home.path,
          pageBuilder: (context, state) => FadeTransitionPage(
            child: const NumberTrivaPage(),
            key: state.pageKey,
            name: RouterPath.home.name,
          ),
        ),
      ],
    );
  },
);

class MyNavObserver extends NavigatorObserver {
  final log = Logger('MyNavObserver');

  MyNavObserver() {
    log.onRecord.listen((e) => debugPrint('$e'));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    log.info(
      'currentRoute : ${route.str}, previousRoute= ${previousRoute?.str}',
    );
  }
}

extension on Route<dynamic> {
  String get str => ' ${settings.name}';
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required LocalKey key,
    required Widget child,
    required String name,
  }) : super(
          key: key,
          name: name,
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          child: child,
        );

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}
