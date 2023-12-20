import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/screens/user_data_page.dart';
import '../services/firebase_services.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
        centerTitle: true,
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
                bool registered = await FirebaseServices().registration(
                  email: controllerEmail.text,
                  password: controllerPassword.text,
                );
                if (registered == true) {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserDataPage(),
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
                'Next',
                style: TextStyle(fontSize: 29),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
