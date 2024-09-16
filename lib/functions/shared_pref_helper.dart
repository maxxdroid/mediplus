import 'dart:convert';

import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefhelper {
  static String userIDKey = 'UserIdKey';

  Future<void> saveMedication(List<Medication> medicines) async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList =
        medicines.map((medicine) => jsonEncode(medicine.toJson())).toList();
    await prefs.setStringList('medications', medicineList);
  }

  Future<List<Medication>> getCurrentMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList = prefs.getStringList('medications') ?? [];
    return medicineList
        .map((json) => Medication.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveMedicationCart(List<Medication> medicines) async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList =
        medicines.map((medicine) => jsonEncode(medicine.toJson())).toList();
    await prefs.setStringList('cart', medicineList);
  }

  Future<List<Medication>> getCurrentMedicationCart() async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList = prefs.getStringList('cart') ?? [];
    return medicineList
        .map((json) => Medication.fromJson(jsonDecode(json)))
        .toList();
  }

  Future<void> saveUser(LocalUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final medicationJson = jsonEncode(user.toJson());
    await prefs.setString('user', medicationJson);
  }

  Future<LocalUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final Map<String, dynamic> userMap = jsonDecode(user);
      return LocalUser.fromJson(userMap);
    }
    return null;
  }

  Future<bool> saveUserID(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIDKey, getUserId);
  }

  Future<String?> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIDKey);
  }
}
