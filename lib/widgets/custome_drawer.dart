import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  void _rateApp() async {
    final url = Uri.parse('https://play.google.com/store/apps/details?id=com.example.app');
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _shareApp() {
    Share.share('سلام! این اپ درمانگر سبز رو امتحان کن: https://play.google.com/store/apps/details?id=com.example.app');
  }

  void _changeLanguage(BuildContext context) {
    Locale newLocale = Locale('en', 'US');
    MyApp.setLocale(context, newLocale);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.white : Colors.deepPurple.shade100,
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/logo/logo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'درمانگر سبز',
                      style: TextStyle(
                        fontFamily: 'Vazir',
                        fontSize: 16,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.star_rate, color: isDarkMode ? Colors.white : Colors.deepPurple),
              title: const Text('امتیاز به برنامه', style: TextStyle(fontFamily: 'Vazir')),
              onTap: _rateApp,
            ),

            ListTile(
              leading: Icon(Icons.share, color: isDarkMode ? Colors.white : Colors.deepPurple),
              title: const Text('اشتراک گذاری', style: TextStyle(fontFamily: 'Vazir')),
              onTap: _shareApp,
            ),

            ListTile(
              leading: Icon(Icons.settings, color: isDarkMode ? Colors.white : Colors.deepPurple),
              title: const Text('تنظیمات', style: TextStyle(fontFamily: 'Vazir')),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('تنظیمات'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.language, color: isDarkMode ? Colors.white : Colors.deepPurple),
                            title: const Text('تغییر زبان', style: TextStyle(fontFamily: 'Vazir')),
                            onTap: () {
                              _changeLanguage(context);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('fa', 'IR');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(title: Text('درمانگر سبز')),
        drawer: CustomDrawer(),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
