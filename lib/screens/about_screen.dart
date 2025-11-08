import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mission Section
          Image.asset("assets/8.png", height: 180),
          const SizedBox(height: 12),
          Text(
            "Our Mission",
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "At E-nfo Hub, our mission is to empower individuals and communities with the "
            "knowledge they need to handle e-waste properly. By providing clear, accessible "
            "information, we help reduce the harmful impact of discarded electronics on our "
            "environment and health.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 30),

          // Vision Section
          Image.asset("assets/3.png", height: 180),
          const SizedBox(height: 12),
          Text(
            "Our Vision",
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "We envision a world where technology and sustainability go hand in hand, "
            "where electronic devices are managed in a way that leaves no harmful trace on the planet.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 30),

          // Who We Serve Section
          Text(
            "Who We Serve",
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Our website is for everyone:",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 16),
          ),
          const SizedBox(height: 20),

          // Info Cards
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _infoBox(
                  "Students",
                  "looking to learn about environmental responsibility.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoBox(
                  "Households",
                  "who want to manage old gadgets sustainably.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _infoBox(
                  "Businesses",
                  "aiming to reduce their electronic footprint.",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _infoBox(
                  "Communities",
                  "building eco-friendly habits together.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          // Contact Form Section
          Text(
            "Suggestion Form",
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Have questions, ideas, or feedback? Fill out our form "
            "with your name, email, and message, and we'll get back "
            "to you as soon as possible.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 30),

          Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField("Name", _nameController),
                const SizedBox(height: 16),
                _buildTextField("Email", _emailController),
                const SizedBox(height: 16),
                _buildTextField("Feedback", _feedbackController, maxLines: 4),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B7A3C),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Feedback submitted!")),
                      );
                      // Clear form
                      _nameController.clear();
                      _emailController.clear();
                      _feedbackController.clear();
                    }
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
              
          ),
          const SizedBox(height: 30),
        ],
      ),
       
    );
    
    
  }

  Widget _infoBox(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F5E7),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(),
        filled: true,
        fillColor: const Color(0xFFE9F5E7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: GoogleFonts.inter(),
      validator: (value) =>
          value == null || value.isEmpty ? "Please enter $label" : null,
    );
  }
}