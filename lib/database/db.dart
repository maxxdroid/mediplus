import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:mediplus/screens/tabs/page_tabs.dart';

class DatabaseMethods {
  addUserInfo(String userId, Map<String, dynamic> userInfoMap) {
    FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }

  addMedication(Map<String, dynamic> medication, File image) async {
    String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
    String downloadurl = await uploadimage(image, dVariable);
    medication["image"] = downloadurl;
    FirebaseFirestore.instance
        .collection("medication")
        .doc(dVariable)
        .set(medication)
        .whenComplete(() {
      Get.to(const PageTabs(),
          transition: Transition.cupertino,
          duration: const Duration(seconds: 1));
    });
  }

  uploadimage(File image, String dVariable) async {
    final Reference reference = FirebaseStorage.instance.ref().child('items');
    UploadTask storageUploadTask =
        reference.child('medication_$dVariable .jpg').putFile(image);
    TaskSnapshot taskSnapshot = await storageUploadTask;
    String downloadurl = await taskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }
}
