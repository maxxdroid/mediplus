import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mediplus/models/medication.dart';

class OrdersModel {
  String status;
  List<Medication> medications;
  DateTime date;
  String userID;
  String orderId;
  String name;
  String email;

  OrdersModel(
      {required this.status,
      required this.userID,
      required this.date,
      required this.name,
      required this.email,
      required this.orderId,
      required this.medications});

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      status: json['status'],
      medications: (json['medications'] as List<dynamic>)
          .map((item) => Medication.fromJson(item as Map<String, dynamic>))
          .toList(),
      date: (json['date'] as Timestamp).toDate(),
      orderId: json['orderId'],
      name: json['name'],
      email: json['email'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'medications': medications.map((med) => med.toJson()).toList(),
      'userID': userID,
      'date': date,
      'orderId' : orderId,
      'email' : email,
      'name' : name
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersModel &&
        other.status == status &&
        other.medications == medications &&
        other.date == date &&
        other.userID == userID &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        medications.hashCode ^
        date.hashCode ^
        name.hashCode ^
        email.hashCode ^
        userID.hashCode;
  }
}
