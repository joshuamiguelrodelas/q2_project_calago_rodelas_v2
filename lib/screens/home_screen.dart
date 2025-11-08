import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'learn_screen.dart';
import 'about_screen.dart';
import 'quiz_intro_screen.dart';
import 'chatbot_screen.dart';
import 'news_article_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  // Updated content data with working URLs and fallback images
  final List<Map<String, dynamic>> featuredContent = [
    {
      'type': 'article',
      'title': 'The Growing E-Waste Problem',
      'description': 'Learn about the global e-waste crisis and its impact',
      'image': 'assets/7.png',
      'date': 'Dec 2024',
      'source': 'UN Environment',
      'content': 'Electronic waste is one of the fastest-growing waste streams in the world. With technology advancing rapidly, more devices are being discarded than ever before. In 2024 alone, over 50 million tons of e-waste were generated globally. Proper e-waste management is crucial for environmental protection and resource conservation. Many electronic devices contain valuable materials like gold, silver, and copper that can be recovered through recycling.',
      'externalUrl': 'https://www.unep.org/news-and-stories/story/global-e-waste-surging',
    },
    {
      'type': 'video',
      'title': 'How to Properly Recycle Electronics',
      'description': 'Step-by-step guide to recycling your old devices safely',
      'image': 'assets/2.png',
      'date': 'Nov 2024',
      'source': 'Eco Warriors',
      'content': 'Recycling electronics properly helps recover valuable materials and prevents hazardous substances from contaminating the environment. Always follow these steps:\n\n1. Remove personal data from devices\n2. Find certified e-waste recyclers\n3. Never throw electronics in regular trash\n4. Consider donating working devices\n5. Check for manufacturer take-back programs',
    },
    {
      'type': 'tips',
      'title': '5 Easy Ways to Reduce E-Waste',
      'description': 'Simple changes you can make today to help the planet',
      'image': 'assets/10.png',
      'date': 'Jan 2024',
      'source': 'Green Living',
      'content': 'Here are 5 simple ways you can help reduce electronic waste:\n\n1. Repair instead of replace - Fix broken devices when possible\n2. Donate working devices - Give old electronics to schools or charities\n3. Buy refurbished electronics - Save money and reduce waste\n4. Choose durable products - Invest in quality that lasts longer\n5. Recycle responsibly - Use certified e-waste recycling centers',
    },
    {
      'type': 'news',
      'title': 'New E-Waste Recycling Laws',
      'description': 'Latest government regulations on electronic waste disposal',
      'image': 'assets/3.png',
      'date': 'Oct 2024',
      'source': 'Environmental News',
      'content': 'Governments worldwide are implementing stricter e-waste regulations to combat the growing environmental threat. These new laws require manufacturers to take responsibility for their products throughout their lifecycle, from production to disposal. Extended Producer Responsibility (EPR) programs are becoming mandatory in many countries, forcing companies to manage the recycling of their products.',
      'externalUrl': 'https://www.epa.gov/recycle/electronics-donation-and-recycling',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Welcome Widget
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Ennie Image
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Image.asset(
                      "assets/ennieadjusted.png",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco,
                          size: 60,
                          color: Color(0xFF6E7230),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Welcome Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to EnfoHub!",
                          style: GoogleFonts.inter(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF6E7230),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your eco-friendly companion for learning about e-waste management and recycling.",
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Feature Buttons Grid
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  _buildFeatureButton(
                    icon: Icons.menu_book,
                    title: "Learn",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Learn"),
                            backgroundColor: Colors.white,
                          ),
                          body: LearnScreen(),
                        )),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.quiz,
                    title: "Quiz",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Quiz"),
                            backgroundColor: Colors.white,
                          ),
                          body: const QuizIntroScreen(),
                        )),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.chat,
                    title: "Chat With Ennie",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatBotScreen()),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.info_outline,
                    title: "About",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("About"),
                            backgroundColor: Colors.white,
                          ),
                          body: AboutScreen(),
                        )),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.recycling,
                    title: "Recycling Tips",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Recycling Tips"),
                            backgroundColor: Colors.white,
                          ),
                          body: LearnScreen(),
                        )),
                      );
                    },
                  ),
                  _buildFeatureButton(
                    icon: Icons.lightbulb_outline,
                    title: "Suggestions",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Suggestions"),
                            backgroundColor: Colors.white,
                          ),
                          body: AboutScreen(),
                        )),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Featured Content Section
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Content",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF6E7230),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6E7230).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Updated Weekly",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF6E7230),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Stay informed with the latest news, tips, and videos about e-waste",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Horizontal scrollable content cards
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredContent.length,
                      itemBuilder: (context, index) {
                        final content = featuredContent[index];
                        return Container(
                          width: 250,
                          margin: EdgeInsets.only(
                            right: index == featuredContent.length - 1 ? 0 : 12,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsArticleScreen(content: content),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image container
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                      color: const Color(0xFFE9F5E7),
                                      image: content['image'] != null 
                                        ? DecorationImage(
                                            image: AssetImage(content['image']!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                    ),
                                    child: Stack(
                                      children: [
                                        // Fallback icon if no image
                                        if (content['image'] == null)
                                          const Center(
                                            child: Icon(
                                              Icons.article,
                                              size: 40,
                                              color: Color(0xFF6E7230),
                                            ),
                                          ),
                                        
                                        // Type badge
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: _getTypeColor(content['type']),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              _getTypeText(content['type']),
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Content
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          content['title'],
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF6E7230),
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          content['description'],
                                          style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Text(
                                              content['date'],
                                              style: GoogleFonts.inter(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(Icons.arrow_forward, size: 16, color: Color(0xFF6E7230)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'article':
        return Colors.blue;
      case 'video':
        return Colors.red;
      case 'tips':
        return Colors.green;
      case 'news':
        return Colors.orange;
      default:
        return const Color(0xFF6E7230);
    }
  }

  String _getTypeText(String type) {
    switch (type) {
      case 'article':
        return 'ARTICLE';
      case 'video':
        return 'VIDEO';
      case 'tips':
        return 'TIPS';
      case 'news':
        return 'NEWS';
      default:
        return 'CONTENT';
    }
  }

  Widget _buildFeatureButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF6E7230).withOpacity(0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF6E7230).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 34,
              color: const Color(0xFF6E7230),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6E7230),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}