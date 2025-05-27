import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../models/job.dart';
import 'package:helafix_mobile_app/theme/colors.dart';
import 'package:helafix_mobile_app/theme_provider.dart';

class UpdateBookingPage extends StatefulWidget {
  const UpdateBookingPage({super.key});

  @override
  State<UpdateBookingPage> createState() => _UpdateBookingPageState();
}

class _UpdateBookingPageState extends State<UpdateBookingPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  DateTime? _selectedDateTime;
  String? jobId;
  Job? job;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    Future.delayed(Duration.zero, () {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args != null && args.containsKey('jobId')) {
        jobId = args['jobId'];
        _fetchJob();
      }
    });
  }

  Future<void> _fetchJob() async {
    if (jobId == null) return;
    final snapshot =
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();

    if (snapshot.exists && snapshot.data() != null) {
      job = Job.fromMap(snapshot.data()!, snapshot.id);
      setState(() {
        _descriptionController.text = job?.description ?? '';
        _selectedDateTime = job?.createdAt ?? DateTime.now();
      });
    }
  }

  Future<void> _pickDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? today,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: today.add(const Duration(days: 7)),
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDateTime?.hour ?? 0,
          _selectedDateTime?.minute ?? 0,
        );
      });
    }
  }

  Future<void> _pickTime() async {
    final List<TimeOfDay> allowedTimes = [
      const TimeOfDay(hour: 8, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 12, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 16, minute: 0),
    ];

    final TimeOfDay? selectedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Time'),
        children: allowedTimes.map((time) {
          return SimpleDialogOption(
            child: Text(time.format(context)),
            onPressed: () => Navigator.pop(context, time),
          );
        }).toList(),
      ),
    );

    if (selectedTime != null) {
      final date = _selectedDateTime ?? DateTime.now();
      setState(() {
        _selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  Future<void> _updateJob() async {
    if (_formKey.currentState?.validate() != true ||
        jobId == null ||
        job == null) return;

    try {
      await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
        'description': _descriptionController.text,
        'createdAt': _selectedDateTime ?? job!.createdAt,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking updated successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating job: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 183, 255),
      ),
      body: job == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: themeProvider.isDarkMode
                    ? AppColours.backgroundGradientDark
                    : AppColours.backgroundGradientLight,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      title: Text(
                        'Date: ${_selectedDateTime?.toLocal().toString().split(' ')[0] ?? 'Not selected'}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _pickDate,
                    ),
                    ListTile(
                      title: Text(
                        'Time: ${_selectedDateTime != null ? TimeOfDay.fromDateTime(_selectedDateTime!).format(context) : 'Not selected'}',
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: _pickTime,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _updateJob,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Update Booking',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
