import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled1/Views/email_verify_view.dart';
import 'package:untitled1/Views/login_view.dart';
import 'package:untitled1/Views/notes_view.dart';
import 'package:untitled1/Views/register_view.dart';
import 'package:untitled1/services/auth/auth_services.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light
    )
  );
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
      ),
      // themeMode: ThemeMode.dark,
      // darkTheme:ThemeData(brightness: Brightness.dark),
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
              return const Notes();
            }
          default:
            Future.delayed(const Duration(seconds: 2)
            );

            return const Center(
                child: CircularProgressIndicator());
        }
      },
    );
    // );
  }
}
