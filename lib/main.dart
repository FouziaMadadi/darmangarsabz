

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';


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
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.green,
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeWithTestButton extends StatelessWidget {
  const HomeWithTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomeScreen(),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              // ************************************************
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('اتصال به Firebase موفق بود!')),
              );
              FirebaseFirestore.instance.collection('test').add({
                'message': 'سلام انجینر صاحب فوزیه جان',
                'time': Timestamp.now(),
              });
            },
            child: Icon(Icons.cloud_done),
            tooltip: 'تست اتصال',
          ),
        ),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.green, // رنگ سبز برای AppBar
//         ),
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }
//
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('درمانگر سبز')),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: const [
//           ListTile(title: Text('گیاه اول')),
//           ListTile(title: Text('گیاه دوم')),
//           ListTile(title: Text('گیاه سوم')),
//         ],
//       ),
//     );
//   }
// }


