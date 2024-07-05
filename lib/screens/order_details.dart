import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/orders.dart';
import 'package:mediplus/screens/cart.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class OrderDetails extends StatefulWidget {
  final OrdersModel order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
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
      cartItems = cart.length;
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
            padding: const EdgeInsets.all(10),
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
                        const Text(
                          "Order Details",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Order By:  ${widget.order.name}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "Email :  ${widget.order.email}",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.7,
                    width: width,
                    child: ListView.builder(
                        itemCount: widget.order.medications.length,
                        itemBuilder: (context, index) {
                          return productCard(widget.order.medications[index]);
                        }),
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
                        // remove();
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
                            "Reject",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const LoadingAlert(
                                message: 'Approving Order',
                              );
                            });
                        String message = await DatabaseMethods().approveOrder(
                            widget.order.medications, widget.order.userID);
                        if (message == "success") {
                          print(".............$message");
                        }
                        print(".............$message");
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
                            "Aprove",
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
