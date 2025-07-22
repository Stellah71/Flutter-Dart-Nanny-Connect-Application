import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';
import 'screens/role_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(NannyConnectApp());
}

class NannyConnectApp extends StatelessWidget {
=======
import 'screens/login_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

>>>>>>> 24af94e0fe0ab53f801cd5ff54c1dc216ea9a0a6
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NannyConnect',
      theme: ThemeData(primarySwatch: Colors.blue),
<<<<<<< HEAD
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasData) {
            return RoleSelectionScreen();
          }
          return LoginScreen();
        },
      ),
=======
      initialRoute: '/', // Start with LoginScreen
      routes: {
        '/': (context) => LoginScreen(), // Define the route for the login screen
        '/home': (context) => HomeScreen(), // Define the route for the home screen (after login)
        '/register': (context) => NannyRegisterScreen(), // Define the route for the nanny registration screen
      },
>>>>>>> 24af94e0fe0ab53f801cd5ff54c1dc216ea9a0a6
    );
  }
}
