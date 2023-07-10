/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 15:21:44
 * @modify date 07-07-2023 15:21:44
 * @desc [description]
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads/src/auth/login_or_register.dart';
import 'package:threads/src/presentation/pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
