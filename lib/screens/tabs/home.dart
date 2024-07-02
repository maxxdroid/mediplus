import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/screens/details_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            const EdgeInsets.only(left: 20.0, right: 20, bottom: 10, top: 20),
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
                  Container(
                    height: 40,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      // controller: _typeController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 10, left: 10),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 3,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(
                              Icons.search,
                            ),
                          ),
                          border: InputBorder.none),
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
                      Positioned(bottom: 0, right: 0, child: Text("$cartItems"))
                    ],
                  )
                ],
              ),
            ),
            ..._medicationTypes.map((type) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        type,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .25,
                    child: medications(context, type),
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
      child: Column(
        children: [
          SizedBox(
            height: height * .22,
            width: width * .4,
            child: Card(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  medication.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(medication.name)
        ],
      ),
    );
  }
}
