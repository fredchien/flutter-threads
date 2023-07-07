/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 07-07-2023 08:57:08
 * @modify date 07-07-2023 08:57:08
 * @desc [description]
 */
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation colorAnimation;
  late Animation sizeAnimation;

  void initializeSplash() async {
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    sizeAnimation = Tween<double>(begin: 100.0, end: 260.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });
    controller.repeat();
    initializeSplash();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2e3192),
      body: Center(
        child: Container(
          height: sizeAnimation.value,
          width: sizeAnimation.value,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
