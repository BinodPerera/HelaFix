import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/pages/category_pages/cate_dt.dart'; // Assuming this is CartDt
import 'package:helafix_mobile_app/pages/category_pages/sub_repairs_page.dart';

class HomePageCat extends StatefulWidget {
  final String categoryId;

  const HomePageCat({
    super.key,
    required this.categoryId,
  });

  @override
  State<HomePageCat> createState() => _HomePageCatState();
}

class _HomePageCatState extends State<HomePageCat> {
  final CollectionReference subCategoryCollection =
      FirebaseFirestore.instance.collection('sub_categories');

  late Future<String> _categoryNameFuture;

  @override
  void initState() {
    super.initState();
    _categoryNameFuture = _fetchCategoryName();
  }

  Future<String> _fetchCategoryName() async {
    final doc = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryId)
        .get();

    return doc.exists ? (doc.data()?['name'] ?? 'Unknown Category') : 'Unknown Category';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: FutureBuilder<String>(
          future: _categoryNameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return Text(
                snapshot.data!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: subCategoryCollection
              .where('category_id', isEqualTo: widget.categoryId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No sub-categories found.'));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final doc = docs[index];
                final data = doc.data() as Map<String, dynamic>;
                final subCategoryId = doc.id;
                final name = data['name'] ?? 'No Name';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartDt(
                            subCategoryId: subCategoryId,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
