/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 08:57:15
 * @modify date 07-07-2023 08:57:15
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:threads/src/auth/login_or_register.dart';
import 'package:threads/src/presentation/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      initialRoute: '/splash',
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginOrRegister(),
      },
    );
  }
}
