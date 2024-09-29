import 'package:alwattar_group_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key,required this.student_id});

  final String student_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,iconTheme: IconThemeData(color: Colors.white),
        title: const Text('الملخص المالي',style: TextStyle(color: Colors.white),),
        backgroundColor: kColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: [
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 16),
            // Payment Details Section
            _buildPaymentDetails(),
            const SizedBox(height: 16),
            // Table Section (Dynamic from Firestore)
            _buildPaymentTable(),
          ],
        ),
      ),
    );
  }

// Profile Widget with Firestore data
Widget _buildProfileSection() {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('students')
        .doc(student_id) // استبدل بـ ID الطالب
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data == null) {
        return const Center(child: Text('لا توجد بيانات متاحة'));
      }

      // جلب بيانات الملف الشخصي من الوثيقة
      var data = snapshot.data!.data() as Map<String, dynamic>;
      String studentName = data['name'] ?? 'اسم غير معروف';
      String studentClass = data['studentClass'] ?? 'صف غير معروف';

      return Column(
        children: [
           CircleAvatar(
            radius: 35,
            backgroundColor: kColor,
            child: Image.asset("assets/profile.png"),
          ),
          const SizedBox(height: 10),
          Text(
            studentName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            studentClass,
            style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 53, 52, 52)),
          ),
        ],
      );
    },
  );
}


// Payment Summary Details Widget (Fetching data from Firestore)
Widget _buildPaymentDetails() {
  return StreamBuilder<DocumentSnapshot>(
    stream: FirebaseFirestore.instance
        .collection('students')
        .doc(student_id) // استبدل بـ ID الطالب
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (!snapshot.hasData || snapshot.data == null) {
        return const Center(child: Text('لا توجد بيانات متاحة'));
      }

      // جلب بيانات القسط من الوثيقة
      var data = snapshot.data!.data() as Map<String, dynamic>;
int paid_payment=data['totalInstallments']-data['remainingInstallment'];
      // المتغيرات التي تحتوي على القيم المطلوبة
      String totalPayment = '${data['totalInstallments']} IQD';
      String paidPayment = '${paid_payment} IQD';
      String adminDiscount = '${data['discount']} IQD';
      String hasDiscount = data['hasBrother'] ;
      String remainingPayment = '${data['remainingInstallment']} IQD';

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryCard('القسط المدفوع', paidPayment),
              _buildSummaryCard('القسط الكلي', totalPayment),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryCard('خصم الادارة', adminDiscount),
              _buildSummaryCard("هل يوجد خصم", hasDiscount),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryCard('القسط المتبقي', remainingPayment),
            ],
          ),
        ],
      );
    },
  );
}

  // Card Widget
  Widget _buildSummaryCard(String title, String amount) {
    return Expanded(
      child: Card(
        color:kColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                amount,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Payment Table Widget (Dynamic from Firestore using a list inside a document)
  Widget _buildPaymentTable() {
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('students')
                  .doc(student_id) // استبدل بـ ID الطالب
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('لا توجد بيانات متاحة'));
                }

                // جلب قائمة الدفعات من الوثيقة
                var data = snapshot.data!.data() as Map<String, dynamic>;
                List<dynamic> payments = data['installmentsList']; // قائمة الدفعات

                return SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 50,
                    dividerThickness: 1,
                    columns: const [
                      // DataColumn(
                      //   label: Text('الدفعه'),
                      // ),
                      DataColumn(
                        label: Text('المبلغ'),
                      ),
                      DataColumn(
                        label: Text('المتبقي'),
                      ),
                      DataColumn(
                        label: Text('التاريخ'),
                      ),
                    ],
                    
                    rows: payments.map((payment) {
                      return DataRow(cells: [
                        
                        DataCell(Text('${payment['pidInstallment']} IQD')),
                        DataCell(Text('${payment['remainingInstallment']} IQD')),
                        DataCell(Text(payment['date'])),
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
