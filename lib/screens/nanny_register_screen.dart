import 'package:flutter/material.dart';
import 'db_helper.dart';

class NannyRegisterScreen extends StatefulWidget {
  @override
  _NannyRegisterScreenState createState() => _NannyRegisterScreenState();
}

class _NannyRegisterScreenState extends State<NannyRegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();

  Future<void> _registerNanny() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final experience = _experienceController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || experience.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    // Add nanny to local database
    await _dbHelper.insertNanny({
      'name': name,
      'email': email,
      'phone': phone,
      'experience': experience,
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nanny registered successfully')));
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register as Nanny')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: 'Phone')),
            TextField(controller: _experienceController, decoration: InputDecoration(labelText: 'Experience')),
            ElevatedButton(onPressed: _registerNanny, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
