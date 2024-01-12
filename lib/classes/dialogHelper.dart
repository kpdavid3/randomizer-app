import 'package:flutter/material.dart';

class DialogHelper {
  static Future<bool> showClincherConfirmationDialog(
      BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Proceed to Clincher Round?"),
              content: Text(
                  "Are you sure you want to proceed to the Clincher round?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop(false); // Return false
                  },
                ),
                TextButton(
                  child: Text("Proceed"),
                  onPressed: () {
                    Navigator.of(context).pop(true); // Return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // In case the dialog is dismissed, return false
  }
}
