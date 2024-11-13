import 'package:flutter/material.dart';
import 'package:user_registration/view/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:user_registration/view/login_screen.dart';
import 'package:user_registration/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCoueiu5jNTCaBFfbOg8TUEECpVlekM17g",
      appId: "1:779766549908:android:e7575daf76166b240e1381",
      messagingSenderId: "779766549908",
      projectId: "user-register-ad192",
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const Loginscreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }
}
