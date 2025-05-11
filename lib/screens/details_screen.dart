import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class PlantDetailsScreen extends StatefulWidget {
  final String docId;
  final String collectionName;
  final String type;

  const PlantDetailsScreen(
      {super.key,
      required this.docId,
      required this.collectionName,
      required this.type});

  @override
  State<PlantDetailsScreen> createState() => _PlantDetailsScreenState();
}

class _PlantDetailsScreenState extends State<PlantDetailsScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    print(widget.collectionName);
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDarkMode ? Colors.grey[900] : const Color(0xFFF3E5F5),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection(widget.collectionName.trim())
                .doc(widget.docId.trim())
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox.shrink();
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Text('نام گیاه پیدا نشد');
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;
              final title = data['name'] ?? 'نام گیاه';

              return Text(
                title.toString().trim(),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(widget.collectionName)
              .doc(widget.docId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.purple));
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(child: Text('داده‌ای یافت نشد.'));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;
            final imageUrl = data['image'] ?? 'assets/images/default.jpg';
            final appearance =
                data['description'] ?? data['appearance'] ?? 'ناموجود';
            final benefits = data['benefits'] ?? 'ناموجود';
            final usage = data['usage_method'] ?? data['usage'] ?? 'ناموجود';
            final sideEffects = data['sideEffects'] ?? 'ناموجود';

            return Column(
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(16, 90, 16, 16),
                        // Reduced bottom margin
                        padding: const EdgeInsets.fromLTRB(20, 90, 12, 20),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[850] : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedIndex == 0
                                  ? 'مشخصات و خواص'
                                  : selectedIndex == 1
                                      ? 'روش استفاده'
                                      : 'عوارض جانبی',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:
                                    isDarkMode ? Colors.white : Colors.black87,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                  child: SingleChildScrollView(
                                    key: ValueKey<int>(selectedIndex),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        selectedIndex == 0
                                            ? '${appearance.toString().trim()}\n\n${widget.type == 'plant' ? benefits : ''}'
                                            : selectedIndex == 1
                                                ? usage.toString().trim()
                                                : sideEffects.toString().trim(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.6,
                                          color: isDarkMode
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              // Reduced vertical padding
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textDirection: TextDirection.rtl,
                                children: [
                                  tabButton(
                                      Icons.info, 'مشخصات', 0, isDarkMode),
                                  tabButton(Icons.local_cafe, 'استفاده', 1,
                                      isDarkMode),
                                  if (widget.type == 'plant')
                                    tabButton(Icons.monitor_heart, 'عوارض', 2,
                                        isDarkMode)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor:
                                isDarkMode ? Colors.grey[850] : Colors.white,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: imageUrl.startsWith('http')
                                  ? NetworkImage(imageUrl)
                                  : AssetImage(imageUrl) as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget tabButton(IconData icon, String label, int index, bool isDarkMode) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.purple[600]
              : isDarkMode
                  ? Colors.grey[800]
                  : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : isDarkMode
                      ? Colors.white70
                      : Colors.black54,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : isDarkMode
                        ? Colors.white70
                        : Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
