import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class MyUpgradeAlert extends UpgradeAlert {
  MyUpgradeAlert({super.key, super.upgrader, super.child});

  /// Override the [createState] method to provide a custom class
  /// with overridden methods.
  @override
  UpgradeAlertState createState() => MyUpgradeAlertState();
}

class MyUpgradeAlertState extends UpgradeAlertState {
  @override
  void showTheDialog({
    Key? key,
    required BuildContext context,
    required String? title,
    required String message,
    required String? releaseNotes,
    required bool barrierDismissible,
    required UpgraderMessages messages,
  })
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('업데이트'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('최신 버전이 있습니다.'),
                  Text('\n\n패치노트\n$releaseNotes'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('나중에'),
                onPressed: () {
                  onUserLater(context, true);
                },
              ),
              TextButton(
                child: const Text('업데이트 하기'),
                onPressed: () {
                  onUserUpdated(context, !widget.upgrader.blocked());
                },
              ),
            ],
          );
        });
  }
}