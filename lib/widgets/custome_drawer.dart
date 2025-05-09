import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer.CustomeDrawer({super.key});

  void _rateApp() async {
    final url = Uri.parse('https://play.google.com/store/apps/details?id=com.example.app');
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _shareApp() {
    Share.share('سلام! این اپ درمانگر سبز رو امتحان کن: https://play.google.com/store/apps/details?id=com.example.app');
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
                color: isDarkMode ? Colors.deepPurple : Colors.deepPurple.shade100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.local_florist, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'درمانگر سبز',
                    style: TextStyle(
                      fontFamily: 'Vazir',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'نسخه رایگان',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: Icon(Icons.star_rate, color: isDarkMode ? Colors.white : Colors.deepPurple),
              title: const Text('امتیاز به اپ', style: TextStyle(fontFamily: 'Vazir')),
              onTap: _rateApp,
            ),

            ListTile(
              leading: Icon(Icons.share, color: isDarkMode ? Colors.white : Colors.deepPurple),
              title: const Text('اشتراک گذاری', style: TextStyle(fontFamily: 'Vazir')),
              onTap: _shareApp,
            ),
          ],
        ),
      ),
    );
  }
}
