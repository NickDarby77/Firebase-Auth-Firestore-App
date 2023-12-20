import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/services/firebase_services.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerReset = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: TextField(
            controller: controllerReset,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () async {
                  bool isEmailReset = await FirebaseServices().resetPassword(
                    email: controllerReset.text,
                  );
                  if (isEmailReset) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ERROR'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.send),
              ),
              hintText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
