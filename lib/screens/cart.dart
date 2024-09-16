import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mediplus/database/db.dart';
import 'package:mediplus/functions/shared_pref_helper.dart';
import 'package:mediplus/models/medication.dart';
import 'package:mediplus/models/user.dart';
import 'package:mediplus/screens/tabs/admin_page_tabs.dart';
import 'package:mediplus/widgets/loading_alert.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool inCart = false;
  List<Medication> cart = [];
  int cartItems = 0;
  LocalUser? user =
      LocalUser(name: "", role: "", imageUrl: "", userID: "", email: "");

  @override
  void initState() {
    // _getUserId();
    _loadcart();
    _getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getUser() async {
    user = await Sharedprefhelper().getUser();
    print('Fetching user info: ${user!.email}');
  }

  Future<void> _loadcart() async {
    cart = await Sharedprefhelper().getCurrentMedicationCart();
    setState(() {
      cartItems = cart.length;
    });
  }

  void remove(Medication medication) async {
    setState(() {
      cart.remove(medication);
      cartItems = cart.length;
    });
    await Sharedprefhelper().saveMedicationCart(cart);
  }

  void emptyCart() async {
    setState(() {
      cart = [];
      cartItems = cart.length;
    });
    await Sharedprefhelper().saveMedicationCart(cart);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 120,
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            if (cart.isNotEmpty) {
              Map<String, dynamic> orderInfoMap = {
                "userID": user!.userID,
                "email": user!.email,
                "name": user!.name,
                "medications":
                    cart.map((medication) => medication.toJson()).toList(),
                "status": "pending",
                "date": DateTime.now()
              };
              showDialog(
                  context: context,
                  builder: (_) {
                    return const LoadingAlert(
                      message: 'Creating Order',
                    );
                  });
              List<String> medicationIds = cart.map((med) => med.id).toList();
              String message =
                  await DatabaseMethods().addOrderInfo(orderInfoMap);
              if (message == "success") {
                emptyCart();
                Get.to(() => PageTabs(
                      user: user!,
                    ));
                print(".............$message");
              } else {
                Fluttertoast.showToast(msg: "Empty Cart");
              }
            }
          },
          child: const Text(
            "Order Medication",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
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
                    const Text(
                      "Cart",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {},
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * .9,
                child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return productCard(cart[index]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
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
                      SizedBox(
                        width: width * .5,
                        child: Text(
                          medication.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: width * .5,
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
                      remove(medication);
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
