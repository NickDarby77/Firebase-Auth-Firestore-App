import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/services/firebase_services.dart';
import 'package:lesson41_auth_firebase/screens/home_page.dart';
import 'package:lesson41_auth_firebase/screens/register_page.dart';
import 'package:lesson41_auth_firebase/screens/reset_password_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerEmail = TextEditingController();
    final TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth'),
        centerTitle: true,
        leading: const SizedBox.shrink(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: controllerEmail,
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controllerPassword,
              decoration: InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                bool authResult = await FirebaseServices().authByEmail(
                  email: controllerEmail.text,
                  password: controllerPassword.text,
                );
                if (authResult) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('ERROR'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                fixedSize: const Size(350, 50),
                foregroundColor: Colors.indigo,
                backgroundColor: Colors.amber,
              ),
              child: const Text(
                'Auth',
                style: TextStyle(fontSize: 29),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage(),
                  ),
                );
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  ),
                );
              },
              child: const Text(
                'Registration',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
