import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:register/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAt3vKfSeUSa0aFsEVyW5M0MewxOr5zpH0",
        appId: "1:1042518870361:web:a02f6649f5bd2f8ad3e448",
        messagingSenderId: "1042518870361",
        projectId: "fire-setup-293f4",
        storageBucket: "fire-setup-293f4.appspot.com",
        authDomain: "fire-setup-293f4.firebaseapp.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
