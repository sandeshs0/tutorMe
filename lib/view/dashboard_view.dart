import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
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
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.tune, color: Colors.grey),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Popular Tutors Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Tutors',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('SEE ALL'),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPopularTutorCard(context),
                    _buildPopularTutorCard(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('SEE ALL'),
                  )
                ],
              ),
  const SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child:  Row(
    children: [
      Text(
        'Physics',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      SizedBox(width: 20),
      Text(
        'Computer Science',
        style: TextStyle(
            color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      SizedBox(width: 20),
      Text(
        'Video Animation',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
      SizedBox(width: 20),
      Text(
        'Video Animation',
        style: TextStyle(color: Colors.grey, fontSize: 14),
      ),
    ],
    ),
  ),

              const SizedBox(height: 20),

              // Recommended Section
              const Text(
                'Recommended for you',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildRecommendationCard(context),
                  _buildRecommendationCard(context),
                  _buildRecommendationCard(context),
                  _buildRecommendationCard(context),
                ],
              ),
            ],
          ),
        ),
      ),bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 40, 73),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'BROWSE'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline), label: 'INBOX'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined), label: 'WALLET'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }

  Widget _buildPopularTutorCard(BuildContext context) {
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
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
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
                  Text('4311',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Students',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('140',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  // Widget _buildCategoryChip(String label) {
  //   return Chip(
  //     label: Text(label),
  //     backgroundColor: Colors.white,
  //     elevation: 2,
  //     shadowColor: Colors.grey.withOpacity(0.3),
  //   );
  // }

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
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
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
        style: TextStyle(fontSize: 12, color: Colors.blue[800]),
      ),
    );
  }
}
