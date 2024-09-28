import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

class StudentProfile extends StatefulWidget {
  StudentProfile({super.key, required this.firestore, this.firestoreTest, this.userID});
  
  final FirebaseFirestore firestore;
  late String? firestoreTest;
  late String? userID;

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String studentName = "";
  String studentClass = ""; // Ensure this is properly loaded
  String? studentEmail;
  var userId;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // جلب بيانات الطالب من Firestore
  Future<void> getStudentData() async {
    try {
      DocumentSnapshot studentData = await widget.firestore
          .collection("students")
          .doc(widget.userID)
          .get();

      if (studentData.exists) {
        setState(() {
          studentName = studentData["name"];
          studentClass = studentData["studentClass"];
        });
      } else {
        print("No student data found.");
      }
    } catch (e) {
      print("Error fetching student data: $e");
    }
  }

  // تحميل بيانات المستخدم المحفوظة مسبقًا
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userID');
    if (userId != null) {
      setState(() {
        widget.userID = userId;
        getStudentData(); // Load student data once user ID is available
      });
    }
  }

  // إزالة البيانات المحفوظة
  Future<void> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('firestoreSave');
    await prefs.remove('userID');
    // await prefs.clear(); // يمكنك استخدام هذا إذا كنت تريد مسح كل البيانات
  }
                    final String telegramGroupUrl = "https://t.me/+5yDk6RkU6B04NmVi";


  // Function to open the URL
  Future<void> _launchTelegramUrl(String telUrl) async {
    final Uri url = Uri.parse(telUrl);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Open in external app
    )) {
      throw 'Could not launch $telegramGroupUrl';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColor,
        actions: [
          IconButton(
            onPressed: () {
              removeData();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة المستخدم
            const CircleAvatar(
              radius: 30,
              backgroundColor: kColor,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: kColor),
              ),
            ),
            const SizedBox(height: 16),
            // اسم الطالب
            Text(
              studentName.isEmpty ? "جارٍ التحميل..." : studentName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
           Text(
              studentClass.isEmpty ? "جارٍ التحميل..." : studentClass,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // العناوين
            Container(
              color: kColor,
              child: const Padding(
                padding: EdgeInsets.all(3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 1, child: Text("التواصل",textAlign: TextAlign.right, style: TextStyle(color: Colors.white,fontSize: 13))),
                    Expanded(flex: 3, child: Text("استاذ المادة",textAlign: TextAlign.right, style: TextStyle(color: Colors.white,fontSize: 13))),

                    Expanded(flex: 2, child: Text("التقييم",textAlign: TextAlign.right, style: TextStyle(color: Colors.white,fontSize: 13))),

                    Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: Text("المادة", style: TextStyle(color: Colors.white,fontSize: 13), textAlign: TextAlign.right))),
                  ],
                ),
              ),
            ),
            // قائمة المواد والتقييمات
            Expanded(
              child: studentClass.isEmpty
                  ? const Center(child: CircularProgressIndicator()) // Show loading until studentClass is available
                  : StreamBuilder<QuerySnapshot>(
                      stream: widget.firestore.collection(studentClass).snapshots(), // Safely use the studentClass
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var postDoc = snapshot.data!.docs[index];
                            var subjectName = postDoc['sub'];

                            return FutureBuilder<DocumentSnapshot>(
                              future: widget.firestore
                                  .collection(studentClass)
                                  .doc(postDoc.id)
                                  .collection("evaluation")
                                  .doc(widget.userID)
                                  .get(),
                              builder: (context, userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return const ListTile(title: Text("Loading user..."));
                                }
                                var userDoc = userSnapshot.data!;
                                var userGrade = userDoc.exists ? userDoc['dgree'] : "لا يوجد تقييم";
                                // var teacherName =userDoc.exists ? userDoc['teacher'] : "لا يوجد تقييم";
                                var teacherName = postDoc['teacher'] ;
                                var telegramUrl = postDoc['telGroup'] ;



                                return _buildTableRow(subjectName,teacherName, userGrade,telegramUrl);
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),
            // الأزرار السفلية
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('المعلومات المالية', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('مركز الاشعارات', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لبناء صف لكل مادة
  Widget _buildTableRow(String subject,String teacher, String grade,String telUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 35,
              child: ElevatedButton(
                onPressed: () async {
  _launchTelegramUrl(telUrl);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kColor,
                  padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child:Directionality(textDirection: TextDirection.rtl, child: Icon(Icons.send,color: Colors.white,)),
              ),
            ),
          ),
          Expanded(flex: 3, child: SizedBox(height: 35, child: Text(teacher,textAlign: TextAlign.right,))),

          Expanded(flex: 2, child: SizedBox(height: 35, child: Text(grade,textAlign: TextAlign.right))),
          Expanded(flex: 3, child: SizedBox(height: 35, child: Text(subject, textAlign: TextAlign.right))),
        ],
      ),
    );
  }
}
