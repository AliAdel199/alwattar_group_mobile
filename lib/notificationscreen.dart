import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String studentDocumentId ;

   NotificationScreen({super.key,required this.studentDocumentId}); // قم بتعديل هذا المعرف

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xff004d40),
          title: const Text('الإشعارات والتبليغات',style: TextStyle(color: Colors.white),),
          bottom: const TabBar(labelColor: Colors.blue,unselectedLabelColor:  Colors.white,indicatorColor: Colors.blue,overlayColor: MaterialStatePropertyAll(Colors.black12),
            tabs: [
              Tab(text: 'إشعارات الاستلام'),
              Tab(text: 'إشعارات عامة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // تبويب الإشعارات المالية
            PaymentNotificationsTab(studentDocumentId: studentDocumentId),
            // تبويب التبليغات العامة
            GeneralNotificationsTab(studentDocumentId: studentDocumentId),
          ],
        ),
      ),
    );
  }
}

// ويدجت لعرض تبويب الإشعارات المالية
class PaymentNotificationsTab extends StatelessWidget {
  final String studentDocumentId;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  PaymentNotificationsTab({required this.studentDocumentId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('students')
          .doc(studentDocumentId) // معرف المستند الخاص بالطالب
          .collection('notification') // مجموعة الإشعارات المالية
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var notifications = snapshot.data!.docs;

        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد إشعارات استلام متاحة',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Directionality(textDirection: TextDirection.rtl,
                child: PaymentNotificationCard(
                  message: notification['message'],
                  paidAmount: notification['paid_amount'],
                  remainingAmount: notification['remaining_amount'],
                  timestamp: notification['timestamp'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ويدجت لعرض تبويب التبليغات العامة
class GeneralNotificationsTab extends StatelessWidget {
  final String studentDocumentId;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GeneralNotificationsTab({required this.studentDocumentId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('notifications')// مجموعة التبليغات العامة
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var notifications = snapshot.data!.docs;

        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              'لا يوجد إشعارات عامة متاحة',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            var notification = notifications[index];
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Directionality(textDirection: TextDirection.rtl,
                child: GeneralNotificationCard(
                  message: notification['message'],
                  timestamp: notification['timestamp'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Directionality لعرض إشعارات الدفع في شكل بطاقة
class PaymentNotificationCard extends StatelessWidget {
  final String message;
  final int paidAmount;
  final int remainingAmount;
  final String timestamp;

  const PaymentNotificationCard({
    Key? key,
    required this.message,
    required this.paidAmount,
    required this.remainingAmount,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var formattedDate = "${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}";
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
                timestamp,
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
  final String timestamp;

  const GeneralNotificationCard({
    Key? key,
    required this.message,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var formattedDate = "${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')}";
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
            const SizedBox(height: 18.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                timestamp,
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
