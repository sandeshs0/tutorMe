import 'package:flutter/material.dart';
import 'package:tutorme/view/browse_view.dart';
import 'package:tutorme/view/home_view.dart';
import 'package:tutorme/view/inbox_view.dart';
import 'package:tutorme/view/profile_view.dart';
import 'package:tutorme/view/wallet_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    const HomeScreen(),
    const BrowseScreen(),
    const InboxScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f8ff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(0, 89, 62, 62),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 10,),
            Text('Hi, Sandesh',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active,
                color: Color.fromARGB(255, 4, 32, 91)),
            onPressed: () {},
          )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 40, 73),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 14,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'BROWSE'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outline), label: 'INBOX'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'WALLET'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'PROFILE'),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularTutorCard(
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
                radius: 30,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Er. Narendra Kunwar',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text('Machine Learning',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '4.4',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Icon(Icons.star, color: Colors.orange, size: 16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Rate',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('Rs. 230/hour',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Minutes tutored',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('4311', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Students',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('140', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildCategoryChip(String label) {
  Widget _buildRecommendationCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
            radius: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Er. Narendra Kunwar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text('Senior Software Engineer',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildSkillChip('JavaScript'),
                    const SizedBox(width: 5),
                    _buildSkillChip('Node.js'),
                  ],
                )
              ],
            ),
          ),
          const Column(
            children: [
              Text('Rate', style: TextStyle(color: Colors.grey)),
              Text('Rs. 230/hour',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        skill,
        style: const TextStyle(
            fontSize: 12, color: Color.fromARGB(255, 16, 27, 40)),
      ),
    );
  }
}
