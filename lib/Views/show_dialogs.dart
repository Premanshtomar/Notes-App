import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
       return AlertDialog(
          title: const Text('Error!'),
          content: Text(text),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
            },
                child: const Text('ok')
          )
          ],
        );
      });
}


//Used in Notes View.
Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text('Logout?'),
      content: const Text("Sure you want to Logout?"),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        },
            child: const Text('Cancel')),
        TextButton(onPressed: () {
          Navigator.of(context).pop(true);
        },
            child: const Text('Logout'))

      ],
    );
  }).then((value) => value ?? false);
}