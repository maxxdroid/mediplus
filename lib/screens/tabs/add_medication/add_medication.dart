import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/screens/tabs/add_medication/add.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({super.key});

  @override
  State<AddMedication> createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(const AddForm(),transition: Transition.rightToLeftWithFade, duration: const Duration(seconds: 1));
        },
        child: const Icon(Icons.add),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text("Add Medications"),
            )
          ],
        ),
      ),
    );
  }
}
