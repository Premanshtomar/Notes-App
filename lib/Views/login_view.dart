// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:untitled1/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/Views/error_file.dart';
import 'package:untitled1/services/auth/auth_exceptions.dart';
import 'package:untitled1/services/auth/auth_services.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(hintText: "example@xyz.com",
                  border: OutlineInputBorder(),
                  label: Text("Email")),

            ),
            const SizedBox(height: 16,),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Enter your Password',
              border: OutlineInputBorder(),
              label: Text('Password')),
            ),
            const SizedBox(height: 16,),
            TextButton(
              // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey)),
              onPressed: () async {
                final email = _email.text.trim();
                final password = _password.text;
                // if (email.isEmpty || password.isEmpty) {
                //   // Fluttertoast.showToast(
                //   //   msg: 'Please Add Required Fields',
                //   //   toastLength: Toast.LENGTH_SHORT,
                //   //   timeInSecForIosWeb: 1,
                //   //   textColor: Colors.white,
                //   //   backgroundColor: Colors.red,
                //   // );
                //   showErrorDialog(context, "Please Add Required Fields");
                //   return;
                // }
                // UserCredential? firebaseUser;
                try {
                  await AuthServices.firebase().logIn(
                          email: email, password: password);
                  if (AuthServices.firebase().currentUser?.isEmailVerified??false){
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil('/notes/', (route) => false);
                  }else{
                    // ignore: use_build_context_synchronously
                    await AuthServices.firebase().sendEmailVerification();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed('/email_verify/');                }
                } on UserNotFoundAuthException catch (_) {
                  showErrorDialog(context, 'User Not Found.');
                }on WrongPasswordAuthException catch (_) {
                  showErrorDialog(context, 'Wrong Password.');
                }on InvalidEmailAuthException catch (_) {
                  showErrorDialog(context, 'Invalid Email');
                }on GenericAuthException catch (_) {
                  showErrorDialog(context, 'Authentication Error.');
                }

                // if (firebaseUser?.user?.uid != null) {}
                // {
                //   if (email.isEmpty || password.isEmpty) {
                //     showErrorDialog(context, 'something went wrong');
                //     return;
                //   }
                // }
                // print(user.toString());
              },
              child: const Text('Login'),
            ),
            // const SizedBox(height: 16,),
            TextButton(
              // style: TextButton.styleFrom(backgroundColor: Colors.grey),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/register/', (route) => false);
                },
                child: const Text('Not Registered? Register here!'))
          ],
        ),
      ),
    );
  }
}

// Flutter_toast.showToast(
//   msg: e.toString(),
//   toastLength: Toast.LENGTH_SHORT,
//   timeInSecForIosWeb: 1,
//   textColor: Colors.white,
//   backgroundColor: Colors.red,
// );


