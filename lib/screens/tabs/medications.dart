import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';

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
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Medication medication =
                      Medication.fromJson(snapshot.data!.docs[index].data());
                  return productCard(medication);
                });
          }
          return const SizedBox();
        });
  }

  Widget productCard(Medication medication) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Card(
          color: Colors.white,
          child: Container(
              height: 120,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        medication.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 120,
                        height: 30,
                        child: Text(
                          medication.description,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        medication.type,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(10),
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width * .3,
                ),
                IconButton(
                    onPressed: () {
                      // remove(medication);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
