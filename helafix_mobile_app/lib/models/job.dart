import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String jobId; // ✅ Add this
  final String? cardNumber;
  final int cost;
  final int costsp;
  final DateTime createdAt;
  final String description;
  final DateTime endAt;
  final String subcategoriesid;
  final DateTime paymentAt;
  final int paymentId;
  final String providerId;
  final String review;
  final int stars;
  final String status;
  final String? userId;
  final bool providerValue;
  final bool userValue;
  final bool usercost;
  final bool spcost;

  Job({
    required this.jobId, // ✅ Add this to constructor
    this.cardNumber,
    required this.cost,
    required this.costsp,
    required this.createdAt,
    required this.description,
    required this.endAt,
    required this.subcategoriesid,
    required this.paymentAt,
    required this.paymentId,
    required this.providerId,
    required this.review,
    required this.stars,
    required this.status,
    this.userId,
    required this.providerValue,
    required this.userValue,
    required this.usercost,
    required this.spcost,
  });

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    return Job(
      jobId: id, // ✅ assign document ID here
      cardNumber: data['card_number']?.toString(),
      cost: data['cost'] is int
          ? data['cost']
          : int.tryParse(data['cost'].toString()) ?? 0,
      costsp: data['costsp'] is int
          ? data['costsp']
          : int.tryParse(data['cost'].toString()) ?? 0,
      createdAt: (data['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      description: data['description'] ?? '',
      endAt: (data['end_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      subcategoriesid: data['jbid'] ?? id,
      paymentAt: (data['payment_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentId: data['payment_id'] is int
          ? data['payment_id']
          : int.tryParse(data['payment_id'].toString()) ?? 0,
      providerId: data['provider_id'] ?? '',
      review: data['review'] ?? '',
      stars: data['stars'] is int
          ? data['stars']
          : int.tryParse(data['stars'].toString()) ?? 0,
      status: data['status'] ?? '',
      userId: data['user_id'],
      providerValue: data['provider_value'] ?? false,
      userValue: data['user_value'] ?? false,
      usercost: data['usercost'] ?? false,
      spcost: data['spcost'] ?? false,
    );
  }
}
