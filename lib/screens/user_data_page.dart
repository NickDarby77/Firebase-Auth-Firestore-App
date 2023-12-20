import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/models/user_data_model.dart';
import 'package:lesson41_auth_firebase/screens/home_page.dart';
import 'package:lesson41_auth_firebase/services/firebase_services.dart';

class UserDataPage extends StatelessWidget {
  const UserDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerSurName = TextEditingController();
    TextEditingController controllerGender = TextEditingController();
    TextEditingController controllerAge = TextEditingController();
    final service = FirebaseServices();
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controllerSurName,
                decoration: InputDecoration(
                  hintText: 'Surname',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controllerGender,
                decoration: InputDecoration(
                  hintText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: controllerAge,
                decoration: InputDecoration(
                  hintText: 'Age',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  service.createUserData(
                    model: UserDataModel(
                      name: controllerName.text,
                      surName: controllerSurName.text,
                      gender: controllerGender.text,
                      age: controllerAge.text,
                      id: auth.currentUser?.uid,
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  fixedSize: const Size(350, 50),
                  foregroundColor: Colors.indigo,
                  backgroundColor: Colors.amber,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 29),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
