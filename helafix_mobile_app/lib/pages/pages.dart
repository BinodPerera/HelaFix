import 'package:flutter/material.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Card(
              child: ListTile(
                title: const Text('Login Page'),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Register Page'),
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            )

          ],
        ),
      )
    );
  }
}