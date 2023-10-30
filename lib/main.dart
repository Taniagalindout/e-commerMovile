import 'package:e_commerce/kernel/widgets/splash.dart';
import 'package:e_commerce/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'modules/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Splash(),
        '/login': (context) => LoginPage(),
        '/profile': (context) => Profile(),
      },
    );
  }
}
