/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 08:57:15
 * @modify date 07-07-2023 08:57:15
 * @desc [description]
 */
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:threads/firebase_options.dart';
import 'package:threads/src/auth/auth.dart';
import 'package:threads/src/auth/login_or_register.dart';
import 'package:threads/src/presentation/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xFF2e3192),
          ),
          titleTextStyle: TextStyle(
            color: Color(0xFF2e3192),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      home: SplashPage(),
      initialRoute: '/splash',
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginOrRegister(),
        "/auth": (context) => const AuthPage(),
      },
    );
  }
}
