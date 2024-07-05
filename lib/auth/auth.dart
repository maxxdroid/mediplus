import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/tabs/admin_page_tabs.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;

  signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        LocalUser user = LocalUser(
            name: name,
            role: "role",
            imageUrl: "",
            userID: firebaseUser.uid,
            email: email);

        await DatabaseMethods().addUserInfo(firebaseUser.uid, user.toJson());
        await Sharedprefhelper().saveUserID(firebaseUser.uid);
        await Sharedprefhelper().saveUser(user);
        Get.to(PageTabs(user: user,),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1));
      }
    } catch (error) {
      errorHandling(error);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userInfoMap =
              userDoc.data() as Map<String, dynamic>;
          LocalUser localUser = LocalUser.fromJson(userInfoMap);

          await Sharedprefhelper().saveUser(localUser);

          await Sharedprefhelper().saveUserID(firebaseUser.uid);

          Get.to(
            PageTabs(user: localUser,),
            transition: Transition.cupertino,
            duration: const Duration(seconds: 1),
          );
        }
      }
    } catch (error) {
      errorHandling(error);
    }
  }

  void errorHandling(dynamic error) {
    String errorMessage;

    switch (error.code) {
      case "email-already-in-use":
        errorMessage = "Email already used. Go to login page.";
        Get.back();
        break;
      case "wrong-password":
        errorMessage = "Wrong email/password combination.";
        Get.back();
        break;
      case "user-not-found":
        errorMessage = "No user found with this email.";
        Get.back();
        break;
      case "user-disabled":
        errorMessage = "User disabled.";
        Get.back();
        break;
      case "too-many-requests":
        errorMessage = "Too many requests to log into this account.";
        Get.back();
        break;
      case "operation-not-allowed":
        errorMessage = "Server error, please try again later.";
        Get.back();
        break;
      case "invalid-email":
        errorMessage = "Email address is invalid.";
        Get.back();
        break;
      default:
        errorMessage = "Sign up error, please try again later.";
        Get.back();
    }
    Fluttertoast.showToast(msg: errorMessage);
  }
}
