import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lesson41_auth_firebase/models/data_model.dart';
import '../models/user_data_model.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  Future<bool> authByEmail(
      {required String email, required String password}) async {
    bool isAuthorized = false;

    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      isAuthorized = true;
      print(result);
    } catch (e) {
      print(e.toString());
    }
    return isAuthorized;
  }

  Future<bool> resetPassword({required String email}) async {
    bool isReset = false;

    try {
      await auth.sendPasswordResetEmail(email: email);
      isReset = true;
    } catch (e) {
      print(e.toString());
    }
    return isReset;
  }

  Future<bool> registration(
      {required String email, required String password}) async {
    bool isRegistered = false;

    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      isRegistered = true;
    } catch (e) {
      print(e.toString());
    }
    return isRegistered;
  }

  Future<void> createData({required String data, required String image}) async {
    try {
      final doc = store.collection('data').doc();
      final model = DataModel(
        data: data,
        image: image,
        id: doc.id,
      );
      await doc.set(model.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> createUserData({required UserDataModel model}) async {
    try {
      final doc = store.collection('users').doc(model.id);
      await doc.set(model.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<DataModel>> getData() {
    final result = store.collection('data').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (e) => DataModel.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
    return result;
  }

  Stream<List<UserDataModel>> getUserData() {
    final result = store.collection('users').snapshots().map(
          (collection) => collection.docs
              .map(
                (doc) => UserDataModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
    return result;
  }

  removeFromDataBase(String id) async {
    try {
      await store.collection('data').doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

// dnk.kg96@gmail.com
// 123123

// test@gmail.com
