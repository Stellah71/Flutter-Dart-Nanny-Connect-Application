import 'package:flutter/material.dart';
import 'screens/login_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NannyConnect',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Start with LoginScreen
      routes: {
        '/': (context) => LoginScreen(), // Define the route for the login screen
        '/home': (context) => HomeScreen(), // Define the route for the home screen (after login)
        '/register': (context) => NannyRegisterScreen(), // Define the route for the nanny registration screen
      },
    );
  }
}
