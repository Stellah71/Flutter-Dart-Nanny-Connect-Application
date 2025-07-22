import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../nanny_registration_screen.dart';
import '../employer_dashboard_screen.dart';
import 'login_screen.dart';

class RoleWrapper extends StatelessWidget {
  const RoleWrapper({super.key});

  Future<String?> getUserRole() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!doc.exists) return null;

    return doc['role'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserRole(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Scaffold(body: Center(child: CircularProgressIndicator()));

        if (!snapshot.hasData || snapshot.data == null) {
          return LoginScreen(); // fallback if no role saved
        }

        final role = snapshot.data;
        if (role == 'nanny') {
          return NannyRegistrationScreen();
        } else if (role == 'employer') {
          return EmployerDashboardScreen();
        } else {
          return Scaffold(
            body: Center(child: Text("Unknown role: $role")),
          );
        }
      },
    );
  }
}
