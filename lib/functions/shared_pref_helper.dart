import 'dart:convert';

import 'package:mediplus/models/medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefhelper{
  static String userIDKey = 'UserIdKey';

  Future<void> saveMedication(List<Medicine> medicines) async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList = medicines.map((medicine) => jsonEncode(medicine.toJson())).toList();
    await prefs.setStringList('medications', medicineList);
  }

  Future<List<Medicine>> getCurrentMedications() async {
    final prefs = await SharedPreferences.getInstance();
    final medicineList = prefs.getStringList('medications') ?? [];
    return medicineList
        .map((json) => Medicine.fromJson(jsonDecode(json)))
        .toList();  
  }

  Future<bool> saveUserID(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIDKey, getUserId);
  }

  Future<String?> getUserID() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIDKey);
  }
}