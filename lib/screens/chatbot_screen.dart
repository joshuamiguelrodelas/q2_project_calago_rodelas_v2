import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  final String apiKey = "AIzaSyC4N8aRRqQ0t97e1KMFvEHEj1hn3fQFMrA";

  late GenerativeModel _model;
  late ChatSession _chat;
  bool _isFirstInteraction = true;

  // Suggestion buttons
  final List<String> _suggestions = [
    "What is E-waste?",
    "Recycling Tips",
    "Nearby Centers",
    "Environmental Impact"
  ];

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
      model: "gemini-2.0-flash", 
      apiKey: "AIzaSyA5zDCCSH_j6PlVL0EW43fZOMANNZfdHvA",
    );

    _chat = _model.startChat(
      history: [
        Content.text(
          "You are Ennie, a friendly e-waste learning companion. "
          "Always explain in simple, encouraging terms about e-waste, recycling, reuse, and environmental safety. "
          "Do not use markdown formatting like **bold** or *italic* in your responses. Use plain text only."
        ),
      ],
    );

    // Add welcome message when chat starts
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "Hello! I'm Ennie, your eco-friendly assistant 🌱💚\n\nHow can I help you with e-waste and recycling today? ♻️"
        });
      });
      _scrollToBottom();
    });
  }

  void _sendSuggestion(String suggestion) {
    _sendMessage(suggestion);
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
    });

    _controller.clear();
    _scrollToBottom();

    // Check if this is the first user interaction
    if (_isFirstInteraction) {
      _isFirstInteraction = false;
    }

    try {
      final response = await _chat.sendMessage(Content.text(text));
      final reply =
          response.text ??
          "Hi, I'm Ennie! I'm your e-waste learning companion. Ask me anything about e-waste, recycling, or how to care for our planet.";

      // Clean the response text by removing markdown formatting
      final cleanedReply = _cleanResponseText(reply);

      setState(() {
        _messages.add({"sender": "bot", "text": cleanedReply});
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "⚠️ Oops, I couldn't connect right now. Try again later!",
        });
      });
      _scrollToBottom();
    }
  }

  String _cleanResponseText(String text) {
    // Remove markdown formatting
    return text
        .replaceAll('**', '') // Remove bold
        .replaceAll('*', '')  // Remove italics and bullets
        .replaceAll('#', '')  // Remove headers
        .replaceAll('`', '')  // Remove code blocks
        .trim();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF0), // Updated background color
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/ennienew1.png',
              width: 45, // Increased from 32 to 40
              height: 45, // Increased from 32 to 40
              errorBuilder: (context, error, stackTrace) {
                return const CircleAvatar(
                  radius: 20, // Increased from 16 to 20
                  backgroundColor: Color(0xFF6E7230),
                  child: Icon(
                    Icons.eco,
                    size: 20, // Increased from 16 to 20
                    color: Colors.white,
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              "Chat with Ennie",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6E7230), // Updated text color
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white, // White header
        elevation: 2,
        iconTheme: const IconThemeData(color: Color(0xFF6E7230)),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFF6E7230),
                          child: Icon(
                            Icons.eco,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Ask me anything about e-waste! 🌱",
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      bool isUser = msg["sender"] == "user";

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!isUser)
                              SizedBox(
                                width: 50, // Increased from 32 to 40
                                height: 50, // Increased from 32 to 40
                                child: Image.asset(
                                  'assets/ennienew1.png',
                                  errorBuilder: (context, error, stackTrace) {
                                    return CircleAvatar(
                                      radius: 20, // Increased from 16 to 20
                                      backgroundColor: Color(0xFF6E7230),
                                      child: Icon(
                                        Icons.eco,
                                        size: 20, // Increased from 16 to 20
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            if (!isUser) const SizedBox(width: 8),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isUser
                                      ? const Color(0xFF858770) // User message color
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  msg["text"] ?? "",
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    color: isUser
                                        ? Colors.white
                                        : Colors.black87,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ),
                            if (isUser) const SizedBox(width: 8),
                            if (isUser)
                              CircleAvatar(
                                radius: 20, // Increased from 16 to 20
                                backgroundColor: Color(0xFF6E7230), // User avatar color
                                child: Icon(
                                  Icons.person,
                                  size: 25, // Increased from 16 to 20
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Suggestion buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white, // White background for suggestions
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _suggestions.map((suggestion) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ElevatedButton(
                      onPressed: () => _sendSuggestion(suggestion),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F4E9), // Light green background
                        foregroundColor: const Color(0xFF6E7230), // Dark green text
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: Color(0xFF6E7230), // Green border
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        suggestion,
                        style: GoogleFonts.inter(
                          fontSize: 13, // Slightly larger font
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white, // White background for input area
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Ask Ennie about e-waste...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                      maxLines: null,
                      style: GoogleFonts.inter(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6E7230),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6E7230).withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => _sendMessage(_controller.text),
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