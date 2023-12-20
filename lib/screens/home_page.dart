import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson41_auth_firebase/screens/profile_screen.dart';
import 'package:lesson41_auth_firebase/services/firebase_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controllerData = TextEditingController();
    final TextEditingController controllerImage = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Home Page'),
        ),
        foregroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: controllerData,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Type any data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: controllerImage,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Put Image Url',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.amber,
                ),
                onPressed: () {
                  FirebaseServices().createData(
                    data: controllerData.text,
                    image: controllerImage.text,
                  );
                },
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseServices().getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 3,
                            ),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 9),
                              Text(
                                snapshot.data?[index].data ?? '',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              Image.network(snapshot.data?[index].image ?? ''),
                              MaterialButton(
                                onPressed: () {
                                  FirebaseServices().removeFromDataBase(
                                      snapshot.data?[index].id ?? '');
                                },
                                child: const Icon(
                                  Icons.delete_forever,
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
