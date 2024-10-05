import 'package:alwattar_group_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';  // لاستيراد Firebase Firestore

class SubjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Colors.white),
        title: Text('اسم المدرسة هنا',style: TextStyle(color: Colors.white),),
        backgroundColor:kColor,
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('الصف الثالث').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما!'));
          }

          // بيانات المواد التي تم جلبها من Firebase
          final subjects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index]['sub'];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor:Colors.teal[800],elevation: 10,
                    // primary: Colors.teal[800], // لون الخلفية
                    padding: EdgeInsets.symmetric(vertical: 16), // حجم الزر
                  ),
                  onPressed: () {
                    // هنا يمكنك إضافة الحدث عند الضغط على زر المادة
                  },
                  child: Text(
                    subject,
                    style: TextStyle(fontSize: 18,color: Colors.white), // حجم النص
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SubjectsPage(),
  ));
}
