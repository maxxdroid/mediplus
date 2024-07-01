import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  signUp(String email, String password) async {
    late User? firebaseUser;
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    firebaseUser = auth.currentUser;
    Map<String, dynamic> userInfoMap = {
        "Email": email,
        "Name": "name",
        "imgUrl": "",
        "User Id" : firebaseUser!.uid,
      };
      DatabaseMethods().addUserInfo(firebaseUser.uid, userInfoMap);
      Sharedprefhelper().saveUserID(firebaseUser.uid);
  }

  signIn(String email, String password) {
    late User? firebaseUser;
    auth.signInWithEmailAndPassword(email: email, password: password);
    firebaseUser = auth.currentUser;
    Sharedprefhelper().saveUserID(firebaseUser!.uid);
  }
}