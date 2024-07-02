// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/screens/cart.dart';

class DetailsPage extends StatefulWidget {
  final Medication medication;

  const DetailsPage({super.key, required this.medication});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
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

  void add() async {
    setState(() {
      if (!inCart) {
        inCart = true;
        cart.add(widget.medication);
        cartItems = cart.length;
      }
    });
    await Sharedprefhelper().saveMedicationCart(cart);
  }

  void remove() async {
    setState(() {
      if (inCart) {
        inCart = false;
        cart.remove(widget.medication);
        cartItems = cart.length;
      }
    });
    await Sharedprefhelper().saveMedicationCart(cart);
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
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.medication.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Program"),
                  ),
                  Card(
                    elevation: 0,
                    color: Colors.lightBlue[50],
                    child: Container(
                        width: width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: const Text("1 pill everyday at 08:00pm")),
                  ),
                  SizedBox(
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
                  SizedBox(
                    height: height * .1,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        remove();
                        // Get.to(const PageTabs(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              inCart ? Colors.blue : Colors.blueGrey[100]),
                      child: SizedBox(
                        width: width * 0.3,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Remove",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        add();
                        // Get.to(const PageTabs(), transition: Transition.cupertino, duration: const Duration(seconds: 1));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: inCart
                              ? Colors.blueGrey[100]
                              : Colors.blueAccent),
                      child: SizedBox(
                        width: width * 0.3,
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
