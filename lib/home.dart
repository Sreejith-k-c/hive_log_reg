import 'package:flutter/material.dart';

class HiveHome extends StatelessWidget {
  final String email;

  const HiveHome({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Home!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $email!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logout logic here
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
