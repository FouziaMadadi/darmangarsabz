import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final String docId;
  const DetailsScreen({super.key, required this.docId});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int selectedIndex = 0;
  String title = 'در حال بارگذاری...';

  @override
  void initState() {
    super.initState();
    fetchTitle();
  }

  Future<void> fetchTitle() async {
    final doc = await FirebaseFirestore.instance
        .collection('alamat_bimari')
        .doc(widget.docId)
        .get();

    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      setState(() {
        title = data['title'] ?? 'نام بیماری';
      });
    } else {
      setState(() {
        title = 'نام بیماری پیدا نشد';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('alamat_bimari')
            .doc(widget.docId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('داده‌ای یافت نشد.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final imageUrl = data['image'] ?? 'assets/images/default.jpg';
          final generalInfo = data['description'] ?? 'معلومات موجود نیست';
          final usage = data['usage_method'] ?? 'روش استفاده موجود نیست';

          return Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: imageUrl.toString().startsWith('http')
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      selectedIndex == 0 ? generalInfo : usage,
                      style: const TextStyle(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tabButton(Icons.info, 0, 'معلومات عمومی'),
                  const SizedBox(width: 16),
                  tabButton(Icons.local_hospital, 1, 'روش استفاده'),
                ],
              ),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }

  Widget tabButton(IconData icon, int index, String label) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.purple[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
