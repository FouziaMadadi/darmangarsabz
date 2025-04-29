// import 'package:darmajgar_sabz/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'screens/home_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'درمانگر سبز',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(fontFamily: 'Vazir'),
//       home: HerbPage(),
//     );
//   }
// }
//**************************************************************
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'firebase_options.dart';
// import 'screens/home_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'درمانگر سبز',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(fontFamily: 'Vazir'),
//       home: HomeWithTestButton(),
//     );
//   }
// }
//
// class HomeWithTestButton extends StatelessWidget {
//   const HomeWithTestButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         HerbPage(),
//         Positioned(
//           bottom: 16,
//           right: 16,
//           child: FloatingActionButton(
//             onPressed: () {
//               // ************************************************
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('اتصال به Firebase موفق بود!')),
//               );
//               FirebaseFirestore.instance.collection('test').add({
//                 'message': 'سلام انجینر صاحب فوزیه جان',
//                 'time': Timestamp.now(),
//               });
//             },
//             child: Icon(Icons.cloud_done),
//             tooltip: 'تست اتصال',
//           ),
//         ),
//       ],
//     );
//   }
// }
//************************************************************************************************
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'plants_screens/herb_combined_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'درمانگر سبز',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Vazir',
      ),
      home: HerbCombinedPage(),
    );
  }
}
