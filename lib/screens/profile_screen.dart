import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/models/user_data_model.dart';
import 'package:lesson41_auth_firebase/screens/splash_screen.dart';
import 'package:lesson41_auth_firebase/services/firebase_services.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseServices().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserDataModel userData = UserDataModel();

              for (int i = 0; i < snapshot.data!.length; i++) {
                if (FirebaseServices().auth.currentUser?.uid ==
                    snapshot.data?[i].id) {
                  userData = snapshot.data![i];
                }
              }
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${userData.name} ${userData.surName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      '${userData.age}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(
                      '${userData.gender}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser!.delete();
                        } catch (e) {
                          print(e.toString());
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Удалить пользователя',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
