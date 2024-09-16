import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mediplus/models/medication.dart';

class DatabaseMethods {
  addUserInfo(String userId, Map<String, dynamic> userInfoMap) {
    FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }

  Future<String> addOrderInfo(Map<String, dynamic> orderInfoMap) async {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
    String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    orderInfoMap["orderId"] = dVariable;

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("orders").doc(dVariable);
    batch.set(orderRef, orderInfoMap);

    try {
      await batch.commit();
      print("Order successfully added!");
      return 'success';
    } catch (e) {
      print("Failed to add order: $e");
      return 'fail';
    }
  }

  Future<String> addReport(Map<String, dynamic>report) async {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
    String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
    WriteBatch batch = FirebaseFirestore.instance.batch();
    report["reportId"] = dVariable;

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("reports").doc(dVariable);
    batch.set(orderRef, report);

    try {
      await batch.commit();
      print("Report successfully added!");
      return 'success';
    } catch (e) {
      print("Failed to add report: $e");
      return 'fail';
    }
  }

  Future<String> approveOrder(
      List<Medication> medications, String userId) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    try {
      // Iterate through medications and add each one to Firestore
      for (Medication medication in medications) {
        String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
        DocumentReference medRef = FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("medications")
            .doc(dVariable);
        batch.set(medRef, medication.toJson());
      }

      await batch.commit();
      print("Medications successfully added!");
      return 'success';
    } catch (e) {
      print("Failed to add medications: $e");
      return 'fail';
    }
  }

  // Future<String> approveOrder(OrdersModel order,) async {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   String dVariable = DateTime.now().microsecondsSinceEpoch.toString();
  //   DocumentReference orderRef = FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(order.userID)
  //       .collection("medications")
  //       .doc(dVariable);

  //   Map<String, dynamic> orderApprovalMap = order.toJson();
  //   orderApprovalMap['orderId'] = dVariable;

  //   batch.set(orderRef, orderApprovalMap);

  //   try {
  //     // Iterate through medications and add each one to Firestore
  //     for (Medication medication in order.medications) {
  //       DocumentReference medRef = orderRef.collection("medications").doc();
  //       batch.set(medRef, medication.toJson());
  //     }

  //     await batch.commit();
  //     print("Order and medications successfully added!");
  //     return 'success';
  //   } catch (e) {
  //     print("Failed to add order: $e");
  //     return 'fail';
  //   }
  // }

  Future<String> addMedication(
      Map<String, dynamic> medication, File image) async {
    String dVariable = DateTime.now().millisecondsSinceEpoch.toString();
    medication["id"] = dVariable;
    String downloadUrl = await uploadImage(image, dVariable);
    medication["image"] = downloadUrl;

    try {
      FirebaseFirestore.instance
          .collection("medication")
          .doc(dVariable)
          .set(medication);
      return 'success';
    } catch (e) {
      return 'fail';
    }
  }

  Future<String> uploadImage(File imageFile, String imageName) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('images/$imageName');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}
