import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/cart.dart';

class ManageDetailsPage extends StatefulWidget {
  final LocalUser user;
  final Medication medication;

  const ManageDetailsPage({super.key, required this.medication, required this.user});

  @override
  State<ManageDetailsPage> createState() => _ManageDetailsPageState();
}

class _ManageDetailsPageState extends State<ManageDetailsPage> {
  bool inCart = false;
  List<Medication> cart = [];
  int cartItems = 0;
  String? userID = "";

  @override
  void initState() {
    _getUserId();
    _loadcart();
    super.initState();
  }

  Future<void> _getUserId() async {
    userID = await Sharedprefhelper().getUserID();
  }

  Future<void> _loadcart() async {
    cart = await Sharedprefhelper().getCurrentMedicationCart();
    setState(() {
      inCart = cart.contains(widget.medication);
      cartItems = cart.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 10),
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
                                  padding: const EdgeInsets.only(
                                      right: 5.0, bottom: 5),
                                  child: Text("$cartItems"),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.5,
                    width: width,
                    child: Image.network(
                      fit: BoxFit.cover,
                      widget.medication.image,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.medication.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Dosage"),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.lightBlue[50],
                    child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Text(widget.medication.dosage)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Description"),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.lightBlue[50],
                    child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: Text(widget.medication.description)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.blueAccent),
                        child: SizedBox(
                          width: width * 0.3,
                          height: 40,
                          child: const Center(
                            child: Text(
                              "Report",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
