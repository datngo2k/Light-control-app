import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:light_controller_app/Data/Models/User.dart';
import 'package:light_controller_app/Logic/Auth/cubit/auth_cubit.dart';
import 'package:light_controller_app/Logic/Register/cubit/register_cubit.dart';

class UserAPI {
  static FirebaseDatabase database = new FirebaseDatabase();
  static DatabaseReference _userRef = database.reference().child('user');
  static DatabaseReference _adminRef = database.reference().child('admin');
  List<UserApp> users = [];
  FirebaseAuth firebaseAuth;

  Future<RegisterState> signUp(UserApp user, String password) async {
    try {
      firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email, password: password);
      user.uid = FirebaseAuth.instance.currentUser.uid;
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

  Future<List<UserApp>> getAllUsers() async {
    users = [];
    DataSnapshot dataSnapshot = await _userRef.once();
    var keys = dataSnapshot.value.keys;
    var values = dataSnapshot.value;
    for (var key in keys) {
      UserApp user = UserApp.fromSnapshot(values[key]);
      user.key = key;
      users.add(user);
    }
    return users;
  }

  void checkUser(String key, UserApp user){
    _userRef.child(key).update(user.toJson());
  }


  AuthState signIn(String email, String password) {
    firebaseAuth = FirebaseAuth.instance;
    try {
      firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e.toString());
      return AuthLoginFailed(errorMessage: e.toString());
    }
    if (firebaseAuth.currentUser == null) {
      return AuthLoginFailed(errorMessage: "Tên đăng nhập hoặc mật khẩu sai");
    }
    return AuthLoginSuccess();
  }

  Future<bool> isExistAdmin(String email) async {
    bool flag = false;
    await _adminRef
        .orderByChild("email")
        .equalTo(email)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        flag = true;
      }
    });
    return flag;
  }
  Future<bool> isActiveAccount(String email) async {
    bool flag = false;
    await _userRef
        .orderByChild("email")
        .equalTo(email)
        .once()
        .then((DataSnapshot dataSnapshot) {
      if (dataSnapshot.value != null) {
        flag = dataSnapshot.value.entries.elementAt(0).value["isActive"] == 1;
      }
    });
    return flag;
  }

  Future<void> signOut() async {
    return Future.wait([
      firebaseAuth.signOut(),
    ]);
  }
}
