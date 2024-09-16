import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/orders.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/cart.dart';
import 'package:mediplus/screens/order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _HistoryState();
}

class _HistoryState extends State<Orders> {
  bool inCart = false;
  List<Medication> cart = [];
  int cartItems = 0;
  LocalUser? user =
      LocalUser(name: "", role: "", imageUrl: "", userID: "", email: "");

  @override
  void initState() {
    _loadcart();
    _getUser();
    super.initState();
  }

  @override
  void dispose() {
    _loadcart();
    super.dispose();
  }

  Future<void> _getUser() async {
    user = await Sharedprefhelper().getUser();
    print('Error fetching user info: ${user!.email}');
  }

  Future<void> _loadcart() async {
    cart = await Sharedprefhelper().getCurrentMedicationCart();
    setState(() {
      cartItems = cart.length;
    });
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> getAllOrders(
      BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("orders").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  OrdersModel order =
                      OrdersModel.fromJson(snapshot.data!.docs[index].data());
                  return orderCard(order, context);
                });
          }
          return const SizedBox();
        });
  }

  Widget orderCard(OrdersModel order, BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    String formattedDate = DateFormat('MMMM d, yyyy').format(order.date);

    return InkWell(
      onTap: () {
        Get.to(() => OrderDetails(order: order));
      },
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            child: Container(
              height: 120,
              width: width,
              padding: const EdgeInsets.all(0),
              child: Row(
                children: [
                  gridImages(order.medications, width),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          order.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 80,
                        width: 100,
                        child: ListView.builder(
                            itemCount: order.medications.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                // width: 100,
                                child: Text(
                                  "${index + 1}. ${order.medications[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridImages(List<Medication> meds, double width) {
    return SizedBox(
      height: 200,
      width: width * .35,
      child: GridView.builder(
          itemCount: meds.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                meds[index].image,
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 30),
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
                    Container(
                      height: 40,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(bottom: 10, left: 10),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "User Orders",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: height * .75, child: getAllOrders(context))
            ],
          ),
        ),
      ),
    );
  }
}
