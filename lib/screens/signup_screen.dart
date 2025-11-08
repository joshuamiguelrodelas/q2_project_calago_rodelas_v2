import 'package:e_nfohub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _agreeTerms = false;
  bool _obscurePass = true;
  bool _obscureConfirmPass = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signUp() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (!_agreeTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please agree to the Terms & Privacy Policy"),
        ),
      );
      return;
    }

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      setState(() => _isLoading = true);

      // Create user in Firebase Authentication
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      // ✅ Store additional user info in Firestore
      await _firestore.collection('users').doc(user!.uid).set({
        'uid': user.uid,
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      // Optional: Navigate back to login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = "Sign Up failed";
      if (e.code == 'email-already-in-use') {
        message = "This email is already registered";
      } else if (e.code == 'weak-password') {
        message = "Password is too weak (min 6 characters)";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Unexpected error: $e")));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  InputDecoration _buildInputDecoration(
    String label,
    IconData icon, {
    bool isPassword = false,
    VoidCallback? toggle,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF6B7A3C)),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                toggle == _togglePassword
                    ? (_obscurePass ? Icons.visibility_off : Icons.visibility)
                    : (_obscureConfirmPass
                          ? Icons.visibility_off
                          : Icons.visibility),
                color: Colors.grey,
              ),
              onPressed: toggle,
            )
          : null,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF6B7A3C)),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _togglePassword() {
    setState(() => _obscurePass = !_obscurePass);
  }

  void _toggleConfirmPassword() {
    setState(() => _obscureConfirmPass = !_obscureConfirmPass);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFFFFDF6),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 85),
          // Logo and Title
          Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 90,
                  width: 90,
                ),
                const SizedBox(height: 1),
                Text(
                  "E-nfo Hub",
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6B7A3C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          
          // Create Account Header
          Text(
            "Create an Account",
            style: GoogleFonts.inter(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Join E-nfo Hub and start your eco journey",
            style: GoogleFonts.inter(
              fontSize: 17,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),

            TextField(
              controller: _fullNameController,
              decoration: _buildInputDecoration("Full Name", Icons.person),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _buildInputDecoration(
                "Email Address",
                Icons.email_outlined,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: _obscurePass,
              decoration: _buildInputDecoration(
                "Password",
                Icons.lock_outline,
                isPassword: true,
                toggle: _togglePassword,
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPass,
              decoration: _buildInputDecoration(
                "Confirm Password",
                Icons.lock_outline,
                isPassword: true,
                toggle: _toggleConfirmPassword,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: _agreeTerms,
                  onChanged: (value) =>
                      setState(() => _agreeTerms = value ?? false),
                  activeColor: const Color(0xFF6B7A3C),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "I agree to the ",
                      style: const TextStyle(fontSize: 13),
                      children: [
                        TextSpan(
                          text: "Terms of Service",
                          style: const TextStyle(
                            color: Color(0xFF6B7A3C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: const TextStyle(
                            color: Color(0xFF6B7A3C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
  width: double.infinity,
  height: 45,
  child: ElevatedButton(
    onPressed: _isLoading ? null : _signUp,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF6B7A3C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
    ),
    child: _isLoading
      ? const CircularProgressIndicator(color: Colors.white)
      : Text(
          "Sign Up",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
  ),
),

          // Login Link
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
                child: Text(
                  "Log In",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7A3C),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          // Footer Text
          const SizedBox(height: 32),
          Text(
            "By signing up, you're helping create a sustainable future.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}
}