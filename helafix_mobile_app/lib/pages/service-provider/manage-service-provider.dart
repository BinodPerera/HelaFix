import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:helafix_mobile_app/models/service_provider.dart';
import 'package:helafix_mobile_app/services/service_provider_service.dart';
import 'package:helafix_mobile_app/pages/service-provider/edit_service_provider.dart';
import 'package:helafix_mobile_app/components/appbar_title.dart';

import 'package:helafix_mobile_app/theme_provider.dart';
import 'package:helafix_mobile_app/theme/colors.dart';

class ManageServiceProvider extends StatelessWidget {
  const ManageServiceProvider({super.key});

  void _confirmDelete(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this service provider?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop(); // Close the dialog
              await ServiceProviderService.deleteServiceProvider(docId);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Service Provider deleted")),
              );
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _navigateToEditPage(BuildContext context, String docId, ServiceProvider provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditServiceProvider(docId: docId, provider: provider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppbarWithTitle(title: 'Manage Service Providers'),
      body: Container(

        decoration: BoxDecoration(
          gradient: themeProvider.isDarkMode
            ? AppColours.backgroundGradientDark
            : AppColours.backgroundGradientLight
        ),

        child: StreamBuilder<Map<String, ServiceProvider>>(
          stream: ServiceProviderService.getServiceProvidersWithIds(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No service providers found."));
            }
        
            final providerMap = snapshot.data!;
            final providerEntries = providerMap.entries.toList();
        
            return ListView.builder(
              itemCount: providerEntries.length,
              itemBuilder: (context, index) {
                final docId = providerEntries[index].key;
                final provider = providerEntries[index].value;
        
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: provider.imageBytes != null
                        ? Image.memory(provider.imageBytes!, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported),
                    title: Text(provider.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _navigateToEditPage(context, docId, provider),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _confirmDelete(context, docId),
                        ),
                      ],
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
