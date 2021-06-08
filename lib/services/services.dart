import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';

// Laat eerst een waarschuwing zien aan de gebuiker en daarna als die doorwilt gaan
// verstuurd die gebruiker naar launch browser.
Future<void> dialogBeforeSendingToUrl(String url,context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('You should send to outside the app!'),
        content: Text('Do you want to continue?'),
        actions: [
          TextButton(
            onPressed: () {
              launchInBrowser(url);
              Navigator.of(context).pop();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'No',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

void launchInBrowser(String url) {
  final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(url),
      package: 'com.android.chrome');
  intent.launch();
}

