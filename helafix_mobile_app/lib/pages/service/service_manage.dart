// service_manage_page.dart
import 'package:flutter/material.dart';
import 'package:helafix_mobile_app/models/service.dart';
import 'package:helafix_mobile_app/services/ServiceService.dart';
import 'package:helafix_mobile_app/pages/service/service.edit.dart';

class ServiceManagePage extends StatefulWidget {
  @override
  _ServiceManagePageState createState() => _ServiceManagePageState();
}

class _ServiceManagePageState extends State<ServiceManagePage> {
  final ServiceService _serviceService = ServiceService();
  List<Service> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final querySnapshot = await _serviceService.getAllServices();
    setState(() {
      _services = querySnapshot;
    });
  }

  void _confirmDelete(Service service) async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Service"),
        content: Text("Are you sure you want to delete '${service.name}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      await _serviceService.deleteService(service.id!);
      _loadServices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Services")),
      body: ListView.builder(
        itemCount: _services.length,
        itemBuilder: (context, index) {
          final service = _services[index];
          return Card(
            child: ListTile(
              leading: service.imageBytes != null
                  ? Image.memory(service.imageBytes!, width: 50, height: 50)
                  : Icon(Icons.image_not_supported),
              title: Text(service.name),
              subtitle: Text(service.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditServicePage(service: service),
                        ),
                      );
                      _loadServices();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmDelete(service),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 
