import 'package:flutter/material.dart';
import 'package:mediplus/models/user.dart';

class Profile extends StatefulWidget {
  final LocalUser user;
  const Profile({super.key, required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  // Future<void> fetchUserInfo(String id) async {
  //   try {
  //     DocumentSnapshot userDoc =
  //         await FirebaseFirestore.instance.collection('users').doc(id).get();

  //     if (userDoc.exists) {
  //       setState(() {
  //         userInfo = userDoc.data() as Map<String, dynamic>?;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching user info: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: SizedBox(
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/user.png')),
              ),
            ),
            Divider(
              height: 60,
              color: Colors.grey[800],
            ),
            const Text(
              "Name",
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Text(
              widget.user.name,
              style: TextStyle(
                  color: Colors.lightBlueAccent[200],
                  letterSpacing: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Level',
              style: TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            Text(
              '8',
              style: TextStyle(
                  color: Colors.lightBlueAccent[200],
                  letterSpacing: 2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Icon(
                  Icons.email,
                  color: Colors.grey[400],
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.user.name,
                  style: TextStyle(
                      color: Colors.grey[400], fontSize: 18, letterSpacing: 1),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.list_alt_outlined,
                    color: Colors.lightBlueAccent[200],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'My Orders',
                    style: TextStyle(
                        color: Colors.lightBlueAccent[200],
                        letterSpacing: 2,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.lightBlueAccent[200],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Settings",
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 2)),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, "/authtabs");
              },
              child: Row(
                children: [
                  Icon(
                    Icons.power_settings_new_sharp,
                    color: Colors.lightBlueAccent[200],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Log 0ut",
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 2)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
