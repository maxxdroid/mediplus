import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/tabs/admin_page_tabs.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class AddReport extends StatefulWidget {
  final LocalUser user;
  final Medication med;
  const AddReport({super.key, required this.user, required this.med});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  final TextEditingController _descriptionController = TextEditingController();

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
                      'Report a medication',
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
                    height: height * 0.35,
                    child: Image.network(widget.med.image)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: SizedBox(
                  width: width,
                  child: Text(
                    "Medication:  ${widget.med.name}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Text(
                  "Type :  ${widget.med.type}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child: Text("Add Report "),
              ),
              Container(
                height: 200,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 8,
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
                              message: 'Saving Report',
                            );
                          });
                      Map<String, dynamic> report = {
                        "userId": widget.user.imageUrl,
                        "name": widget.user.name,
                        "email": widget.user.email,
                        "medication": widget.med.toJson(),
                        "imageUrl": widget.med.image,
                        "description": _descriptionController.text
                      };
                      String message = await DatabaseMethods().addReport(report);
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
