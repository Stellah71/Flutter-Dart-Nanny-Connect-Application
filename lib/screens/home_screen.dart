import 'package:flutter/material.dart';
import 'db_helper.dart';

class HomeScreen extends StatelessWidget {
  final DBHelper _dbHelper = DBHelper();

  Future<List<Map<String, dynamic>>> _getNannies() async {
    return await _dbHelper.getAllNannies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Nannies')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getNannies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final nannies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: nannies.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(nannies[index]['name']),
                subtitle: Text(nannies[index]['email']),
              );
            },
          );
        },
      ),
    );
  }
}
