import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff004d40),
        title: const Text('الإشعارات والتبليغات'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('NOTIFICATION').orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            var notifications = snapshot.data!.docs;

            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  'لا يوجد إشعارات متاحة',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var notification = notifications[index];
                var type = notification['type'];
                
                if (type == 'payment') {
                  return PaymentNotificationCard(
                    message: notification['message'],
                    paidAmount: notification['additional_info']['paid_amount'],
                    remainingAmount: notification['additional_info']['remaining_amount'],
                    timestamp: notification['timestamp'].toDate(),
                  );
                } else {
                  return GeneralNotificationCard(
                    message: notification['message'],
                    timestamp: notification['timestamp'].toDate(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

// Widget لعرض إشعارات الدفع في شكل بطاقة
class PaymentNotificationCard extends StatelessWidget {
  final String message;
  final int paidAmount;
  final int remainingAmount;
  final DateTime timestamp;

  const PaymentNotificationCard({
    Key? key,
    required this.message,
    required this.paidAmount,
    required this.remainingAmount,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedDate = "${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}";
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('المبلغ المدفوع: $paidAmount'),
            Text('المبلغ المتبقي: $remainingAmount'),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget لعرض التبليغات العامة في شكل بطاقة
class GeneralNotificationCard extends StatelessWidget {
  final String message;
  final DateTime timestamp;

  const GeneralNotificationCard({
    Key? key,
    required this.message,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formattedDate = "${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}";
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.teal[700],
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
