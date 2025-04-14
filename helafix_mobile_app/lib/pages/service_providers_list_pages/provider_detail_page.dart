import 'package:flutter/material.dart';
import 'service_provider.dart';

class ProviderDetailPage extends StatelessWidget {
  final ServiceProvider provider;

  const ProviderDetailPage({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(provider.name),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(''),
      ),
    );
  }
}
