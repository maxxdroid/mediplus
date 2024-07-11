import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/tabs/admin_page_tabs.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class AddForm extends StatefulWidget {
  final LocalUser user;
  const AddForm({super.key, required this.user});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();

  String? _selectedMedicationType;
  final List<String> _medicationTypes = [
    'Tablets',
    'Capsules',
    'Liquids',
    'Topical',
    'Inhalers'
  ];

  bool imageSelected = false;
  late File _pic;
  final picker = ImagePicker();

  Future _selectFromGallery() async {
    var tempImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pic = File(tempImage!.path);
      imageSelected = true;
    });
  }

  Future _captureWithCamera() async {
    var tempImage = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      _pic = File(tempImage!.path);
      imageSelected = true;
    });
  }

  selectImage(ncontext) {
    return showDialog(
        context: ncontext,
        builder: (c) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            children: [
              SimpleDialogOption(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Select from Gallery"),
                    Icon(
                      Icons.filter,
                      color: Colors.blue,
                    )
                  ],
                ),
                onPressed: () {
                  _selectFromGallery();
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Capture with camera"),
                    Icon(
                      Icons.camera,
                      color: Colors.blue,
                    )
                  ],
                ),
                onPressed: () {
                  _captureWithCamera();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  int amount = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Add Prescriptions',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: height * 0.25,
                  // width: width * 0.7,
                  child: imageSelected
                      ? InkWell(
                          onTap: () {
                            selectImage(context);
                          },
                          child: Image.file(_pic),
                        )
                      : IconButton(
                          onPressed: () {
                            selectImage(context);
                          },
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            size: 100,
                          )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Name"),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Dosage"),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: _dosageController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Type"),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedMedicationType,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    items: _medicationTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMedicationType = newValue;
                      });
                    },
                    hint: const Text('Select a medication type'),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Descrirption"),
              ),
              Container(
                height: 150,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const LoadingAlert(
                              message: 'Saving Medication',
                            );
                          });
                      Map<String, dynamic> medication = {
                        "name": _nameController.text,
                        "type": _selectedMedicationType,
                        "dosage": _dosageController.text,
                        "description": _descriptionController.text
                      };
                      // Get.to(const SignUp(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                      String message = await DatabaseMethods()
                          .addMedication(medication, _pic);
                      if (message == "success") {
                        Get.off(()=> PageTabs(user: widget.user));
                        print("..........................$message");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: SizedBox(
                      width: width * 0.1,
                      height: 30,
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
