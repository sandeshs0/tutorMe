import 'package:flutter/material.dart';



class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hi, Sandesh'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 2.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do you want to learn today? Choose a tutor and get to it!',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                ),
                SizedBox(height: 20.0),
                _buildSearchBar(),
                SizedBox(height: 20.0),
                _buildSectionTitle('Popular Tutors'),
                SizedBox(height: 10.0),
                _buildTutorCard(
                  'Er. Narendra Kunwar',
                  'Machine Learning',
                  'Minutes tutored: 4311 | Students: 140',
                  'Rs. 230/hour',
                ),
                _buildTutorCard(
                  'Another Tutor',
                  'Physics',
                  'Minutes tutored: 1200 | Students: 50',
                  'Rs. 200/hour',
                ),
                SizedBox(height: 20.0),
                _buildSectionTitle('Categories'),
                SizedBox(height: 10.0),
                _buildCategories(),
                SizedBox(height: 20.0),
                _buildSectionTitle('Recommended for you'),
                SizedBox(height: 10.0),
                _buildTutorCard(
                  'Er. Narendra Kunwar',
                  'Senior Software Engineer',
                  'Can teach: JavaScript, Node.js, Data Structures',
                  'Rs. 230/hour',
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ), backgroundColor: Colors.blue,
          ),
          child: Text('🔍'),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTutorCard(
      String name, String title, String stats, String rate) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://www.wilsoncenter.org/sites/default/files/media/images/person/james-person-1.jpg'),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  Text(
                    stats,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Text(
              rate,
              style: TextStyle(fontSize: 14.0, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = ['Computer Science', 'Physics', 'Video Animation'];

    return Wrap(
      spacing: 10.0,
      children: categories
          .map((category) => Chip(
                label: Text(category),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Browse',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {},
    );
  }
}