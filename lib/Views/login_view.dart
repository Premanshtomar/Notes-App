// import 'package:firebase_core/firebase_core.dart';
// import 'package:untitled1/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Views/show_dialogs.dart';
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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'asset/login.png'
          ), fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.19, left: MediaQuery
                    .of(context)
                    .size
                    .width * 0.09),
                child: const Text('Welcome\n User...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 55
                  ),
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 2, right: 35, left: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enableSuggestions: false,
                        decoration: InputDecoration(hintText: "example@xyz.com",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),

                            ),
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            label: const Text("Email")
                        ),

                      ),
                      const SizedBox(height: 20,
                      ),

                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            label: const Text('Password')),
                      ),
                      const SizedBox(height: 35,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [const Text('Sign in',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff4c505b)
                          ),
                        ),
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: const Color(0xff4c505b),
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  final email = _email.text.trim();
                                  final password = _password.text;
                                  // UserCredential? firebaseUser;
                                  try {
                                    await AuthServices.firebase().logIn(
                                        email: email, password: password);
                                    if (AuthServices
                                        .firebase()
                                        .currentUser
                                        ?.isEmailVerified ?? false) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                          '/notes/', (route) => false);
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      await AuthServices.firebase()
                                          .sendEmailVerification();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushNamed(
                                          '/email_verify/');
                                    }
                                  } on UserNotFoundAuthException catch (_) {
                                    showErrorDialog(context, 'User Not Found.');
                                  } on WrongPasswordAuthException catch (_) {
                                    showErrorDialog(context, 'Wrong Password.');
                                  } on InvalidEmailAuthException catch (_) {
                                    showErrorDialog(context, 'Invalid Email');
                                  } on GenericAuthException catch (_) {
                                    showErrorDialog(
                                        context, 'Authentication Error.');
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward)
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/register/');
                          },
                            child: const Text('Sign up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff4c505b)
                              ),
                            ),
                          ),
                          TextButton(onPressed: () {

                          },
                            child: const Text('Forget Password',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color(0xff4c505b)
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
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


