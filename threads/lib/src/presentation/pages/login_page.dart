/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 09:48:54
 * @modify date 07-07-2023 09:48:54
 * @desc [description]
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:threads/src/presentation/widgets/button.dart';
import 'package:threads/src/presentation/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    //loading
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      //loading pop
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code == 'wrong-password'
          ? 'Login ou senha inválidos'
          : 'Informe um e-mail válido');
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2e3192),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 50),

                  //welcome message
                  const Text(
                    'Bem vindos ao Vai na Web Threads',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 25),

                  //input email
                  MyTextField(
                    controller: emailTextController,
                    hintText: "E-mail",
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),

                  //input pass
                  MyTextField(
                    controller: passwordTextController,
                    hintText: "Senha",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  //button sign in
                  MyButton(onTap: signIn, text: "Entrar"),

                  const SizedBox(height: 25),

                  //button register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ainda não é membro?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
