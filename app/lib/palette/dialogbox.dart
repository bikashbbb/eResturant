import 'package:flutter/material.dart';

dialogbox(BuildContext context, String title) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Try Again?',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      });
}
