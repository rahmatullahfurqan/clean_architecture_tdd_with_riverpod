import 'package:flutter/material.dart';
import 'package:flutter_tdd_with_riverpod/core/config/theme.dart';
import 'package:go_router/go_router.dart';

import '../service/utilities.dart';

class NotificationErrorWidget extends StatelessWidget {
  final String error;

  const NotificationErrorWidget(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: utils.getFullWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    error,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(utils.getFullWidth(context), 40))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close")),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationEmailSendWidget extends StatelessWidget {
  const NotificationEmailSendWidget(this.error, {super.key});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: utils.getFullHeight(context) * 0.4,
      width: utils.getFullWidth(context),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(child: Image.asset('assets/images/checkemail.png')),
          ),
          Column(
            children: [
              Text(
                "Check your email!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                error,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(utils.getFullWidth(context), 40))),
                onPressed: () {
                  Navigator.pop(context);
                  context.go("/login");
                },
                child: const Text("Oke")),
          )
        ],
      ),
    );
  }
}
