/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 12:16:56
 * @modify date 07-07-2023 12:16:56
 * @desc [description]
 */
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

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
                    'Crie agora sua conta',
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

                  //input pass
                  MyTextField(
                    controller: passwordConfirmTextController,
                    hintText: "Confirme sua senha",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),

                  //button sign in
                  MyButton(onTap: () => {}, text: "Entrar"),

                  const SizedBox(height: 25),

                  //button register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Já é um membro?",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          "Login",
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
