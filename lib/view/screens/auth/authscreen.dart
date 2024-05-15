import 'package:flutter/material.dart';
import 'package:fourfiles/view/screens/auth/widgets/signinscreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return const SignInScreen();
  }
}