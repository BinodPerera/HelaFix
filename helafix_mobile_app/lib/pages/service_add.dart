import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void addUser(BuildContext context) {
    try {
      FirebaseFirestore.instance.collection('users').add({
        'name': nameController.text,
        'email': emailController.text,
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value) {
        nameController.clear();
        emailController.clear();
        setState(() {
          _usersFuture = fetchUsers(); // Refresh the list after adding
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User added successfully')),
        );
      }).catchError((error) {
        print('Error adding user: $error');
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add User to Firestore'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => addUser(context),
                child: Text('Add User'),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _usersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No users found'));
                    } else {
                      List<Map<String, dynamic>> users = snapshot.data!;
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(users[index]['name']),
                            subtitle: Text(users[index]['email']),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
