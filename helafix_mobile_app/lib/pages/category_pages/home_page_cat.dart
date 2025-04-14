import 'package:flutter/material.dart';
import 'repair_button.dart';
import 'sub_repairs_page.dart';
import 'repair_category.dart';

class HomePageCat extends StatelessWidget {
  const HomePageCat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repairs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: repairCategories.length,
          itemBuilder: (context, index) {
            final category = repairCategories[index];
            return RepairButton(
              title: category.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SubRepairsPage(category: category),
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
