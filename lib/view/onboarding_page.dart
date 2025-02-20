import 'package:flutter/material.dart';
import 'package:tutorme/features/auth/presentation/view/login_view.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromRGBO(245, 249, 255, 1),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                buildPage(
                  title: "Expert Guidance Anywhere!",
                  subtitle: "One-on-one sessions with experts, made easy.",
                  imagePath: "assets/illus/onboarding1.png",
                ),
                buildPage(
                  title: "Learn from the Best",
                  subtitle: "Access top experts anytime, anywhere.",
                  imagePath: "assets/illus/onboarding1.png",
                ),
                buildPage(
                  title: "Get Started Today",
                  subtitle: "Sign up and start learning now!",
                  imagePath: "assets/illus/onboarding1.png",
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      height: 10.0,
                      width: _currentIndex == index ? 12.0 : 8.0,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    );
                  }),
                ),
                TextButton(
                  onPressed: () {
                    if (_currentIndex < 2) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                  },
                  child: Text(
                    _currentIndex == 2 ? "Finish" : "Next",
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildPage(
    {required String title,
    required String subtitle,
    required String imagePath}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 250.0),
        const SizedBox(height: 40.0),
        Text(
          title,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16.0),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
