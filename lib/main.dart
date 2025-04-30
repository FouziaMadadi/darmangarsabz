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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_page.dart';

import 'firebase_options.dart';

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
    return ChangeNotifierProvider(
      create: (ctx) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeProvider, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'درمانگر سبز',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

class HomeWithTestButton extends StatelessWidget {
  const HomeWithTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeScreen(),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () {
              // ************************************************
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('اتصال به Firebase موفق بود!')),
              );
              FirebaseFirestore.instance.collection('test').add({
                'message': 'سلام انجینر صاحب فوزیه جان',
                'time': Timestamp.now(),
              });
            },
            tooltip: 'تست اتصال',
            child: const Icon(Icons.cloud_done),
          ),
        ),
      ],
    );
  }
}





