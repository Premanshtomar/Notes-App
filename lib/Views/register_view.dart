// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:untitled1/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Views/error_file.dart';
import 'package:untitled1/services/auth/auth_exceptions.dart';
import 'package:untitled1/services/auth/auth_services.dart';

// import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
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
              label: Text('Email'),
              border: OutlineInputBorder()),

            ),
            const SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(hintText: 'Enter your password',

              label: Text('Password'),
              border: OutlineInputBorder()),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
               try{
                 await AuthServices.firebase().createUser(
                     email: email, password: password);
                 AuthServices.firebase().sendEmailVerification();
                 // ignore: use_build_context_synchronously
                 Navigator.of(context).pushNamed('/email_verify/');
               }on WeakPasswordAuthException catch (e) {
                 showErrorDialog(context, 'Password Is Too Weak');
               }on UserNotFoundAuthException catch (e) {
                 showErrorDialog(context, e.toString());
               }on EmailAlreadyInUseAuthException catch (e) {
                 showErrorDialog(context, 'Email Already In Use.');
               }on InvalidEmailAuthException catch (e) {
                 showErrorDialog(context, 'Invalid Email');
               }on GenericAuthException catch (e) {
                 showErrorDialog(context, 'Authentication Error.');
               }
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                },
                child: const Text('Already Registered? Login here!'))
          ],
        ),
      ),
    );
    // default: return const Text("Loading...");
  }
}
