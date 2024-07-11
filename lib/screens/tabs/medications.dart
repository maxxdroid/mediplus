import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/details_page.dart';
import 'package:mediplus/screens/mamage_medications_details.dart';

class Medications extends StatefulWidget {
  String userID;
  Medications({super.key, required this.userID});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  LocalUser? user =
      LocalUser(name: "", role: "", imageUrl: "", userID: "", email: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Medi",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          Text(
                            "+",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.medical_services,
                              color: Colors.blue,
                            )),
                        const Positioned(
                            bottom: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5.0, bottom: 5),
                              child: Text(""),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.2,
                    width: width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                          fit: BoxFit.fitWidth, "assets/images/medicines.jpg"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue.withOpacity(.05)),
                    height: height * 0.2,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  color: Colors.black.withOpacity(.005),
                                  child: SizedBox(
                                    width: width * 0.7,
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Manage Your Prescriptions",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: height * .9,
                  child: medications(context, widget.userID))
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> medications(
      BuildContext context, String userID) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userID)
            .collection("medications")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10,
                  childAspectRatio: .7,
                ),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Medication medication =
                      Medication.fromJson(snapshot.data!.docs[index].data());
                  return medicationcard(medication, context);
                });
          }
          return const SizedBox();
        });
  }

  Widget medicationcard(Medication medication, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Get.to(ManageDetailsPage(medication: medication, user: user!,));
      },
      child: SizedBox(
        height: height * .22,
        width: width * .4,
        child: Card(
          color: Colors.lightBlue[50],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  medication.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                child: SizedBox(
                  width: width * 3,
                  child: Text(
                    medication.name,
                    style: const TextStyle(fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: width * 3,
                    child: Text(
                  "Dosage: ${medication.dosage}",
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
