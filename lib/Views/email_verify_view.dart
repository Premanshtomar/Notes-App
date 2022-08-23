import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
    // return
    return Scaffold(
      appBar: AppBar(title: const Text('Email verify')),
        body:
        Column(
          children:  [const Text('Send verification mail by clicking button below'),
            TextButton(onPressed: () async{
           final user =  FirebaseAuth.instance.currentUser;
           await user?.sendEmailVerification();
          },
              child: const Text('Click Here'))],
        )
    );
  }
}
