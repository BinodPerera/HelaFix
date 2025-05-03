import 'package:flutter/material.dart';
import 'repair_button.dart';
import 'repair_category.dart';
// ✅ Import the new page
import '../service_providers_list_pages/service_providers_page.dart';

class SubRepairsPage extends StatelessWidget {
  final RepairCategory category;

  const SubRepairsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repairs → ${category.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
          itemCount: category.subRepairs.length,
          itemBuilder: (context, index) {
            final subRepair = category.subRepairs[index];
            return RepairButton(
              title: subRepair,
              onTap: () {
                // ✅ Navigate to ServiceProvidersPage instead of RepairDetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ServiceProvidersPage(subRepairName: subRepair),
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
