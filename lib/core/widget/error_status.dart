import 'package:flutter/material.dart';
import 'package:flutter_tdd_with_riverpod/core/config/theme.dart';
import 'package:go_router/go_router.dart';

import '../config/router.dart';
import '../error/failures.dart';
import '../service/utilities.dart';

class ErrorStatusWidget extends StatelessWidget {
  final ResponseError responseError;

  const ErrorStatusWidget(this.responseError, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: utils.getFullWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: Theme.of(context).dividerColor, width: 3))),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/images/icon_error.png')),
              Column(
                children: [
                  Text(
                    "Oops...",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Theme.of(context).colorRed),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    responseError.error,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size(utils.getFullWidth(context), 40))),
                  onPressed: () {
                    if (responseError.statusCode == 401) {
                      context.go(RouterPath.home.path);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(responseError.statusCode == 401 ? "Ok" : "Close"))
            ],
          ),
        ],
      ),
    );
  }
}
