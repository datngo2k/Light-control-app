

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';

class UserAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _userRef = database.reference().child('user');  
  

  Future<RegisterState> signUp(UserApp user, String password) async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      createUser(user);
      return RegisterSuccessed();
    } catch (e) {
      print(e.toString());
      return RegisterFailed(errorMessage: e.message);
    }
  }

  void createUser(UserApp user) {
    _userRef.push().set(user.toJson());
  }

  void readUser(UserApp user) {
    _userRef.once().then((DataSnapshot dataSnapshot){
      print(dataSnapshot.value);
    });
  }

}