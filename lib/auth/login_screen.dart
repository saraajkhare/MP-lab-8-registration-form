import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:register/auth/auth_service.dart';
import 'package:register/auth/signup_screen.dart';
import 'package:register/home_screen.dart';
import 'package:register/widgets/button.dart';
import 'package:register/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  _login() async {
    final user = await _auth.loginUserWithEmailAndPassword(
      _email.text,
      _password.text,
    );
    if (user != null) {
      log("User Logged In");
      goToHome(context);
    }
  }

  goToSignup(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const SignupScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const HomeScreen()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Login",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              isPassword: true,
              controller: _password,
            ),
            const SizedBox(height: 30),
            CustomButton(label: "Login", onPressed: _login),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: const Text(
                    "Signup",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
