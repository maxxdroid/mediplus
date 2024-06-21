import 'package:flutter/material.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({super.key});

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Center(child: Text("Add Medication"),),
      ),
    );
  }
}