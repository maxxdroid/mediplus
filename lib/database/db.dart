import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  addUserInfo(String userId, Map<String, dynamic> userInfoMap) {
    // String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
    // String? downloadurl;
    FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  } 
}