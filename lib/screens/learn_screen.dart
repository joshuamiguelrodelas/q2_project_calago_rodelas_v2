import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_screen.dart';
import 'chatbot_screen.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                "What is E-Waste?",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Electronic waste, or e-waste, refers to discarded electronic devices "
                "such as old phones, computers, appliances, and accessories. "
                "These contain valuable materials but also harmful substances "
                "if not disposed of properly.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 20),
              _mainButton("About us", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                );
              }),
              const SizedBox(height: 30),

              Text(
                "Types of E-Waste",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Image.asset("assets/10.png", height: 180),
              const SizedBox(height: 16),
              _infoBox("Small gadgets", "Like smartphones, tablets, and accessories."),
              _infoBox("Large appliances", "Such as refrigerators, washing machines, and TVs."),
              _infoBox("Computer accessories", "Keyboards, printers, monitors, and cables."),
              const SizedBox(height: 30),

              Text(
                "How to Manage E-Waste",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Image.asset("assets/7.png", height: 180),
              const SizedBox(height: 16),
              _infoBox("Reduce", "Buy only what you need. Choose durable devices."),
              _infoBox("Reuse", "Donate or sell gadgets that are still functional."),
              _infoBox("Recycle", "Take e-waste to recycling centers."),
              _infoBox("Repair", "Fix broken devices instead of throwing them away."),
              const SizedBox(height: 30),

              Text(
                "Local Solutions",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Image.asset("assets/2.png", height: 180),
              const SizedBox(height: 16),
              Text(
                "Check your community for e-waste collection programs, "
                "drop-off points, and recycling centers. "
                "Some electronics shops also accept devices for disposal.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
        // Chatbot button
        Positioned(
          right: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatBotScreen()),
              );
            },
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: Image.asset("assets/ennienew.png"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _mainButton(String text, VoidCallback onPressed) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF6B7A3C), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF6B7A3C),
        ),
      ),
    );
  }

  Widget _infoBox(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F5E7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.eco, color: Color(0xFF6B7A3C)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $description",
              style: GoogleFonts.inter(fontSize: 16, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}