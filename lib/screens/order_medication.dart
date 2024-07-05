import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/screens/cart.dart';
import 'package:mediplus/screens/details_page.dart';

class OrderMedication extends StatefulWidget {
  const OrderMedication({super.key});

  @override
  State<OrderMedication> createState() => _HomeState();
}

class _HomeState extends State<OrderMedication> {
  List<String> _medicationTypes = [];
  bool inCart = false;
  List<Medication> cart = [];
  int cartItems = 0;

  @override
  void initState() {
    _loadcart();
    super.initState();
    fetchMedicationTypes();
  }

  // Future<void> _getUserId() async {
  //   userID = await Sharedprefhelper().getUserID();
  // }

  Future<void> _loadcart() async {
    cart = await Sharedprefhelper().getCurrentMedicationCart();
    setState(() {
      cartItems = cart.length;
    });
  }

  Future<void> fetchMedicationTypes() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("medication").get();
    List<String> types =
        snapshot.docs.map((doc) => doc['type'] as String).toSet().toList();
    setState(() {
      _medicationTypes = types;
    });
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> medications(
      BuildContext context, String type) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("medication")
            .where("type", isEqualTo: type)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
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

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () {
                            Get.to(const Cart());
                          },
                          icon: const Icon(
                            Icons.medical_services,
                            color: Colors.blue,
                          )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 5.0, bottom: 5),
                            child: Text("$cartItems"),
                          ))
                    ],
                  )
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
                          fit: BoxFit.fitWidth, "assets/images/buy.jpg"),
                    ),
                  ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue.withOpacity(.25)),
                  height: height * 0.2,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: width * 0.4,
                                child: const Text(
                                  "Order from Us",
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: width * .4,
                              child: const Text(
                                  "Caring for You, Every Step of the Way",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // const SizedBox(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 5.0, top: 10),
            //     child: Text(
            //       "Popular Medications",
            //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            ..._medicationTypes.map((type) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 10),
                      child: Text(
                        type,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: SizedBox(
                      height: height * .25,
                      child: medications(context, type),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      )),
    );
  }

  Widget medicationcard(Medication medication, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Get.to(DetailsPage(medication: medication));
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
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  medication.name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Dosage: "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
