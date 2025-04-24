import 'package:flutter/material.dart';

class HerbPage extends StatefulWidget {
  @override
  _HerbPageState createState() => _HerbPageState();
}

class _HerbPageState extends State<HerbPage> {
  int selectedFilter = 0;

  final List<String> filters = ['گیاهان', 'بیماری‌ها', 'علاقه‌مندی‌ها'];

  final List<Map<String, String>> herbs = [
    {"name": "جوانی بادیان", "image": "assets/images/جوانی بادیان.jpg"},
    {"name": "حاک شیر", "image": "assets/images/خاک شیر.jpg"},
    {"name": "نعناع", "image": "assets/images/نعناع.jpg"},
    {"name": "هلیله سیاه", "image": "assets/images/هلیله سیاه.jpg"},
    {"name": "گل همیشه بهار", "image": "assets/images/گل همیشه بهار.jpg"},
    {"name": "شیرین‌بیان", "image": "assets/images/گل گاوزبان.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0C9F3), // رنگ پسزمینه صفحه
      body: SafeArea(
        child: Column(
          children: [
            // عنوان و آیکن
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("درمانگر سبز", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Vazir')),
                  Icon(Icons.menu),
                ],
              ),
            ),

            // نوار جستجو
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'اینجا جستجو نمایید',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
            ),

            // فیلترها
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedFilter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFF5E3A75) : Color(0xFFE0C9F3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          filters[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Vazir',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // لیست گیاهان قابل اسکرول
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: herbs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(herbs[index]['image']!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          herbs[index]['name']!,
                          style: TextStyle(fontFamily: 'Vazir'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // نوار پایین
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF5E3A75),
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.home, color: Colors.white), onPressed: () {}),
              IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          // TODO: حالت شب/روز
        },
        child: Icon(Icons.nightlight_round, color: Color(0xFF5E3A75)),
      ),
    );
  }
}
