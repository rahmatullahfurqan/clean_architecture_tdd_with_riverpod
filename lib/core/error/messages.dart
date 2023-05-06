import 'package:flutter/material.dart';
import 'package:flutter_tdd_with_riverpod/core/config/theme.dart';
import 'package:go_router/go_router.dart';
import '../widget/error_status.dart';
import '../widget/notification_error.dart';
import 'failures.dart';

class ErrorMessageNotification {
  static void handler(BuildContext context, ResponseError responseError) {
    if (responseError.statusCode == 8888) {
      return;
    }
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) {
        return ErrorStatusWidget(responseError);
      },
    ).then((value) =>
        responseError.statusCode == 401 || responseError.statusCode == 301
            ? context.go("/login")
            : null);
  }

  static void localHandler(BuildContext context, String error) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) {
        return NotificationErrorWidget(error);
      },
    );
  }

  static void emailSend(BuildContext context, String message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (builder) {
        return NotificationEmailSendWidget(message);
      },
    ).then((value) => context.go("/login"));
    //
  }
}

void showImpackDialogConfirmation(
    {String uri = "assets/images/approval_effect.png",
    required String title,
    required BuildContext context,
    required Function() onPressed,
    TextStyle? titleStyle}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          buttonPadding: const EdgeInsets.all(10),
          titlePadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 30)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Theme.of(context).buttonSecondary,
                                  width: 1,
                                  style: BorderStyle.solid)),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: onPressed,
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Theme.of(context).buttonSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                              const Size(double.infinity, 40)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                    style: BorderStyle.solid)),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).buttonSecondary,
                          ),
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(title,
                    style:
                        titleStyle ?? Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center),
              ),
              uri.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(height: 100, child: Image.asset(uri)),
                    ),
            ],
          ),
        );
      });
}
