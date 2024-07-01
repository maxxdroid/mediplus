import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/screens/details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Fri, 21st June"),
            const Text(
              "Today's Plan",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text("08:00 am"),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.to(const DetailsPage(),
                    transition: Transition.cupertino,
                    duration: const Duration(seconds: 1));
              },
              child: Card(
                elevation: 0,
                color: Colors.lightBlue[50],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/pill1.png",
                        width: 100,
                        height: 50,
                      ),
                      const Column(
                        children: [
                          Text(
                            "Vitamin C pills",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("1 pill per Day")
                        ],
                      ),
                      Icon(Icons.navigate_next)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * .6,
              child: medications(context),
            )
          ],
        ),
      )),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> medications(
      BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("medication").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  Medication medication =
                      Medication.fromJson(snapshot.data!.docs[index].data());
                  return medicationcard(medication, context);
                });
          }
          return SizedBox();
        });
  }

  Widget medicationcard(Medication medication, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: height * .2,
            width: width * .4,
            child: Image.network(
              medication.image,
              fit: BoxFit.cover,
            ),
          ),
          Text(medication.name)
        ],
      ),
    );
  }
}
