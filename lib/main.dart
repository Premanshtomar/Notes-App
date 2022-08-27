import 'package:flutter/material.dart';
import 'package:untitled1/Views/email_verify_view.dart';
import 'package:untitled1/Views/login_view.dart';
import 'package:untitled1/Views/notes_view.dart';
import 'package:untitled1/Views/register_view.dart';
import 'package:untitled1/services/auth/auth_services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/email_verify/': (context)=> const EmailVerification(),
        '/notes/': (context) => const Notes(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // return Scaffold(
        //   appBar: AppBar(
        //     title: const Text("Home Page"),
        //   ),
        //   body:
        FutureBuilder(
      future: AuthServices.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthServices.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const Notes();
              } else {
                return const EmailVerification();
              }
            } else {
              return const LoginView();
            }
          // if (user?.emailVerified ?? false){
          //   return const Text('Email verified');
          // }else{
          //   // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const EmailVerification()));
          //   return const EmailVerification();
          // }
          // return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
    // );
  }
}
