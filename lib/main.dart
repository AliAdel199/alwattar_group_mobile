import 'package:alwattar_group_mobile/SubjectsPage.dart';
import 'package:alwattar_group_mobile/constant.dart';
import 'package:alwattar_group_mobile/login_page.dart';
import 'package:alwattar_group_mobile/rectanglebtn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'student_profile.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  // ]);
  FirebaseApp alwatar1 = await Firebase.initializeApp(
    name: 'alwatar1',
    options: const FirebaseOptions( 
      apiKey: 'AIzaSyAdlF6U_nSIhErO5mXfjwYj2r6u8vpB__o',
      appId: "1:445722473026:web:adbdd17e29981773a4b3db",
      messagingSenderId: '445722473026',
      projectId: 'alwattar-groups-school1',
    ),
  );
  // تهيئة التطبيق الثاني
  FirebaseApp alwatar2 = await Firebase.initializeApp(
    name: 'alwatar2',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD07LpZ4X83jYLGZI13NfekmgtGXTQREnw',
      appId: "1:589941851286:web:89345f2348d3243ab26eb7",
      messagingSenderId: '589941851286',
      projectId: 'alwattar-groups-school2',
    ),
  );
  FirebaseApp alwatar3 = await Firebase.initializeApp(
    name: 'alwatar3',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyD9ZH_P_Lt-FgVfoP4nMPzDQGak2J7g0JU',
      appId: "1:589010316747:web:8f625e54167e89e63b9a4e",
      messagingSenderId: '589010316747',
      projectId: 'alwattar-groups-school3',
    ),
  );
  FirebaseApp alwatar4 = await Firebase.initializeApp(
    name: 'alwatar4',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCD-8lhT6wyOsk3W5N3ZL-zPw2DiJ7_fy0',
      appId: "1:381821573922:web:ba6d8754b7beeca5f7a37b",
      messagingSenderId: '381821573922',
      projectId: 'alwattar-groups-school4-24070',
    ),
  );
  FirebaseApp alwatar5 = await Firebase.initializeApp(
    name: 'alwatar5',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBbl5T9O0HyDWnrHyx2WSHqRWu98WQPOhw',
      appId: "1:97886565317:web:6f754d651e0963294b11ac",
      messagingSenderId: '97886565317',
      projectId: 'alwattar-groups-school5',
    ),
  );
  FirebaseApp alwatar6 = await Firebase.initializeApp(
    name: 'alwatar6',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBZ_SY-OkNahl78-bgk5LSmEwvfD6ZZeG4',
      appId: "1:766397186191:web:f06274425467dd635bb0fa",
      messagingSenderId: '766397186191',
      projectId: 'alwattar-groups-school6',
    ),
  );
  FirebaseApp alwatar7 = await Firebase.initializeApp(
    name: 'alwatar7',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAHba8_k75OL7fKHF2UJGyaC6rZzX7bygg',
      appId: "1:877282530959:web:793a61f0c3bdba62d002fa",
      messagingSenderId: '877282530959',
      projectId: 'alwattar-groups-school7',
    ),
  );
  FirebaseApp alwatar8 = await Firebase.initializeApp(
    name: 'alwatar8',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCG7nKaf2JbwegGCIz32tCSIwL5hFQhIys',
      appId: "1:435495862597:web:2416e787d9370c01d1fe2c",
      messagingSenderId: '435495862597',
      projectId: 'alwattar-groups-school8',
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore firestore1 = FirebaseFirestore.instanceFor(app: alwatar1);
  firestore1.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth1 = FirebaseAuth.instanceFor(app: alwatar1);

  FirebaseFirestore firestore2 = FirebaseFirestore.instanceFor(app: alwatar2);
  firestore2.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth2 = FirebaseAuth.instanceFor(app: alwatar2);

  FirebaseFirestore firestore3 = FirebaseFirestore.instanceFor(app: alwatar3);
  firestore3.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth3 = FirebaseAuth.instanceFor(app: alwatar3);

  FirebaseFirestore firestore4 = FirebaseFirestore.instanceFor(app: alwatar4);
  firestore4.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth4 = FirebaseAuth.instanceFor(app: alwatar4);

  FirebaseFirestore firestore5 = FirebaseFirestore.instanceFor(app: alwatar5);
  firestore5.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth5 = FirebaseAuth.instanceFor(app: alwatar5);

  FirebaseFirestore firestore6 = FirebaseFirestore.instanceFor(app: alwatar6);
  firestore6.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth6 = FirebaseAuth.instanceFor(app: alwatar6);

  FirebaseFirestore firestore7 = FirebaseFirestore.instanceFor(app: alwatar7);
  firestore7.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth7 = FirebaseAuth.instanceFor(app: alwatar7);

  FirebaseFirestore firestore8 = FirebaseFirestore.instanceFor(app: alwatar8);
  firestore8.settings = const Settings(persistenceEnabled: true);
  FirebaseAuth auth8 = FirebaseAuth.instanceFor(app: alwatar8);

  runApp(MyApp(
    auth1: auth1,
    auth2: auth2,
    auth3: auth3,
    auth4: auth4,
    auth5: auth5,
    auth6: auth6,
    auth7: auth7,
    auth8: auth8,
    firestore1: firestore1,
    firestore2: firestore2,
    firestore3: firestore3,
    firestore4: firestore4,
    firestore5: firestore5,
    firestore6: firestore6,
    firestore7: firestore7,
    firestore8: firestore8,
  ) // Wrap your app
      );
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
    required this.auth1,
    required this.auth2,
    required this.auth3,
    required this.auth4,
    required this.auth5,
    required this.auth6,
    required this.auth7,
    required this.auth8,
    required this.firestore1,
    required this.firestore2,
    required this.firestore3,
    required this.firestore4,
    required this.firestore5,
    required this.firestore6,
    required this.firestore7,
    required this.firestore8,
  });
  final FirebaseAuth auth1;
  final FirebaseAuth auth2;
  final FirebaseAuth auth3;
  final FirebaseAuth auth4;
  final FirebaseAuth auth5;
  final FirebaseAuth auth6;
  final FirebaseAuth auth7;
  final FirebaseAuth auth8;
  final FirebaseFirestore firestore1;
  final FirebaseFirestore firestore2;
  final FirebaseFirestore firestore3;
  final FirebaseFirestore firestore4;
  final FirebaseFirestore firestore5;
  final FirebaseFirestore firestore6;
  final FirebaseFirestore firestore7;
  final FirebaseFirestore firestore8;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
         initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(
          title: 'Flutter Demo Home Page',
          auth1: auth1,
          auth2: auth2,
          auth3: auth3,
          auth4: auth4,
          auth5: auth5,
          auth6: auth6,
          auth7: auth7,
          auth8: auth8,
          firestore1: firestore1,
          firestore2: firestore2,
          firestore3: firestore3,
          firestore4: firestore4,
          firestore5: firestore5,
          firestore6: firestore6,
          firestore7: firestore7,
          firestore8: firestore8),
          // '/userProfile':(context) => SubjectsPage()
      },
      // home: MyHomePage(
      //     title: 'Flutter Demo Home Page',
      //     auth1: auth1,
      //     auth2: auth2,
      //     auth3: auth3,
      //     auth4: auth4,
      //     auth5: auth5,
      //     auth6: auth6,
      //     auth7: auth7,
      //     auth8: auth8,
      //     firestore1: firestore1,
      //     firestore2: firestore2,
      //     firestore3: firestore3,
      //     firestore4: firestore4,
      //     firestore5: firestore5,
      //     firestore6: firestore6,
      //     firestore7: firestore7,
      //     firestore8: firestore8),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    required this.title,
    required this.auth1,
    required this.auth2,
    required this.auth3,
    required this.auth4,
    required this.auth5,
    required this.auth6,
    required this.auth7,
    required this.auth8,
    required this.firestore1,
    required this.firestore2,
    required this.firestore3,
    required this.firestore4,
    required this.firestore5,
    required this.firestore6,
    required this.firestore7,
    required this.firestore8,
  });
  final FirebaseAuth auth1;
  final FirebaseAuth auth2;
  final FirebaseAuth auth3;
  final FirebaseAuth auth4;
  final FirebaseAuth auth5;
  final FirebaseAuth auth6;
  final FirebaseAuth auth7;
  final FirebaseAuth auth8;
  final FirebaseFirestore firestore1;
  final FirebaseFirestore firestore2;
  final FirebaseFirestore firestore3;
  final FirebaseFirestore firestore4;
  final FirebaseFirestore firestore5;
  final FirebaseFirestore firestore6;
  final FirebaseFirestore firestore7;
  final FirebaseFirestore firestore8;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;


Future<void> loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? firestoreSave = prefs.getString('firestoreSave');
  String? uid = prefs.getString('userID');


  switch (firestoreSave){
    case "firestore1":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "1",userID: uid)));
        break;
    case "firestore2":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "2",userID: uid)));
        break;
    case "firestore3":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "3",userID: uid)));
        break;
    case "firestore4":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "4",userID: uid)));
        break;
    case "firestore5":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "5",userID: uid)));
        break;
    case "firestore6":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "6",userID: uid)));
        break;
    case "firestore7":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "7",userID: uid)));
        break;
    case "firestore8":
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>StudentProfile(firestore: widget.firestore1,firestoreTest: "8",userID: uid)));
        break;



  }
  
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: kColor,
        title: Text("مدارس الوتار الاهلية",style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
   RectangleButton(title: "مدرسة الوتار الابتدائية الاهلية المختلطة", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen( auth: widget.auth1, firestore: widget.firestore1,firestoreSave:"firestore1" )));}),
   RectangleButton(title: "مدرسة أجيال الوتار الابتدائية الاهلية المختلطة", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth2, firestore: widget.firestore2,firestoreSave:"firestore1" )));}),
   RectangleButton(title: "ثانوية الوتار الاهلية للبنين", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth3, firestore: widget.firestore3,firestoreSave:"firestore3" )));}),
   RectangleButton(title: "ثانوية الوتار الاهلية للبنات", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth4, firestore: widget.firestore4,firestoreSave:"firestore4" )));}),
   RectangleButton(title:"ثانوية اجيال الوتار الاهلية للبنين", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth5, firestore: widget.firestore5,firestoreSave:"firestore5" )));}),
   RectangleButton(title: "مدرسة دار الوتار الابتدائية الاهلية المختلطة", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth6, firestore: widget.firestore6,firestoreSave:"firestore6" )));}),
   RectangleButton(title: "ثانوية دار الوتار الاهلية للبنات", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth7, firestore: widget.firestore7,firestoreSave:"firestore7" )));}),
   RectangleButton(title: "ثانوية دار الوتار الاهلية للبنين", bgColor: kColor, width: 350, onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(auth: widget.auth8, firestore: widget.firestore8,firestoreSave:"firestore8" )));}),

          ],
        ),
      ),
   // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
