import 'package:flutter/material.dart';
import 'nanny_registration_screen.dart';
import 'employer_dashboard_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NannyConnect - Select Role")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("I'm a Nanny"),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NannyRegistrationScreen()));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("I'm an Employer"),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmployerDashboardScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
