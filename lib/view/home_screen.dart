import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        setState(() {
          userData = doc.data() as Map<String, dynamic>?;
        });
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  Future<void> updateUserData(String field, String newValue) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({field: newValue});
        await fetchUserData();
      } catch (e) {
        print("Error updating user data: $e");
      }
    }
  }

  Future<void> deleteUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .delete();
        await _auth.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        print("Error deleting user data: $e");
      }
    }
  }

  void showEditDialog(String field, String currentValue) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $field"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter new $field"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  await updateUserData(field, controller.text);
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text("User Profile"),
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 350,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "Email: ${userData!['email']}",
                          style: GoogleFonts.dmSans(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditDialog("email", userData!['email']);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "password: ${userData!['password']}",
                          style: GoogleFonts.dmSans(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showEditDialog("password", userData!['password']);
                          },
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Account Created time and date: ${userData!['createdAt'].toDate()}",
                          style: GoogleFonts.dmSans(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      ListTile(
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Confirm Delete"),
                                  content: const Text(
                                      "Are you sure you want to delete your account?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await deleteUserData();
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
