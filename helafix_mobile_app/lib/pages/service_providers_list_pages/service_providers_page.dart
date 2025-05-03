import 'package:flutter/material.dart';
import 'service_provider_data.dart';
import 'provider_detail_page.dart';

class ServiceProvidersPage extends StatelessWidget {
  final String subRepairName;
  const ServiceProvidersPage({super.key, required this.subRepairName});

  @override
  Widget build(BuildContext context) {
    final providers = serviceProvidersMap[subRepairName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Providers for $subRepairName'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProviderDetailPage(provider: provider),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        provider.logoUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (starIndex) {
                              return Icon(
                                starIndex < provider.rating.round()
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 18,
                                color: Colors.orange,
                              );
                            }),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            children: provider.availableDates.map((date) {
                              return Chip(
                                label: Text(date),
                                backgroundColor: Colors.blue.shade50,
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
