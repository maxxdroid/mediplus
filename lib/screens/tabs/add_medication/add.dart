import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {

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
                    Icon(Icons.filter, color: Colors.blue,)
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
                    Icon(Icons.camera, color: Colors.blue,)
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
              const EdgeInsets.only(top: 40.0, left: 20, right: 20, bottom: 10),
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
              // Center(child: IconButton(onPressed: () {}, icon: const Icon(Icons.add_a_photo))),
              Center(
                child: SizedBox(
                height: height * 0.15,
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
              const Text("Medication Name"),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Descrirption"),
              const Text("Add a pill description if possible"),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Amount"),
              const Text("How many pills do you have to take at once?"),
              Container(
                  height: 50,
                  width: width,
                  decoration: BoxDecoration(
                      color: Colors.lightBlue[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              amount++;
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(amount.toString()),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(" Pills"),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (amount != 0) {
                                amount--;
                              }
                            });
                          },
                          icon: const Icon(Icons.remove_circle))
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text("Duration"),
              const Text("How many Days do you need to take the pills?"),
              const Row(
                children: [
                  Text("Start Date:"),
                  Text("15th, OCtober 2001")
                ],
              ),
              const Row(
                children: [
                  Text("Start Date:"),
                  Text("15th, OCtober 2001")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Time"),
              const Text("Add what time you need to take the pills"),
              Container(
                height: 60,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(child: Text("7:00 am"))
                ),
              ),
              Center(
                child: Container(
                  height: 40,
                  width: width * 0.6,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text("Add Time"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
