import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsArticleScreen extends StatelessWidget {
  final Map<String, dynamic> content;

  const NewsArticleScreen({super.key, required this.content});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      appBar: AppBar(
        title: Text(content['title']),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with fallback
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFE9F5E7),
                image: content['image'] != null 
                  ? DecorationImage(
                      image: AssetImage(content['image']!),
                      fit: BoxFit.cover,
                    )
                  : null,
              ),
              child: content['image'] == null
                  ? const Icon(
                      Icons.article,
                      size: 60,
                      color: Color(0xFF6E7230),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            
            // Title
            Text(
              content['title'],
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF6E7230),
              ),
            ),
            const SizedBox(height: 10),
            
            // Date and Source
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  content['date'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 15),
                const Icon(Icons.source, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  content['source'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Content
            Text(
              content['content'],
              style: GoogleFonts.inter(
                fontSize: 16,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            
            // Video placeholder for video type
            if (content['type'] == 'video')
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F5E7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.play_circle_filled,
                      size: 60,
                      color: Color(0xFF6E7230),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Video Content: ${content['title']}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6E7230),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'In a future update, we will integrate video players to show educational content about e-waste recycling and management.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            
            // Read More Button (if there's an external link)
            if (content['externalUrl'] != null && content['externalUrl'].isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6E7230),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: () => _launchURL(content['externalUrl']!),
                    child: Text(
                      'Read Full Article',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}