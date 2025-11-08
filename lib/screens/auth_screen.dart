import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  final _storage = const FlutterSecureStorage();

  GoogleSignInAccount? _currentUser;
  bool _isSigning = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    // listen to sign-in changes
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
      if (account != null) {
        _saveAccountToSecureStorage(account);
      }
    });

    _googleSignIn.signInSilently().catchError((_) {
      // ignore, user not previously signed-in
    });
  }

  Future<void> _saveAccountToSecureStorage(GoogleSignInAccount account) async {
    final auth = await account.authentication;
    await _storage.write(key: 'google_access_token', value: auth.accessToken);
    await _storage.write(key: 'google_id_token', value: auth.idToken);
    await _storage.write(key: 'google_email', value: account.email);
    await _storage.write(key: 'google_name', value: account.displayName ?? '');
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isSigning = true;
      _error = null;
    });

    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        // user canceled
        setState(() => _isSigning = false);
        return;
      }
      final auth = await account.authentication;
      // auth.accessToken and auth.idToken available if required by backend
      await _saveAccountToSecureStorage(account);

      setState(() {
        _currentUser = account;
        _isSigning = false;
      });
    } catch (e) {
      setState(() {
        _isSigning = false;
        _error = "Sign in failed: ${e.toString()}";
      });
    }
  }

  Future<void> _handleSignOut() async {
    await _googleSignIn.signOut();
    await _storage.deleteAll();
    setState(() => _currentUser = null);
  }

  Widget _buildSignedIn() {
    final avatar = _currentUser?.photoUrl;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (avatar != null)
          CircleAvatar(radius: 40, backgroundImage: NetworkImage(avatar)),
        const SizedBox(height: 12),
        Text(
          _currentUser?.displayName ?? '',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          _currentUser?.email ?? '',
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _handleSignOut,
          icon: const Icon(Icons.logout),
          label: const Text('Sign out'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton.icon(
      onPressed: _isSigning ? null : _handleSignIn,
      icon: Image.asset('assets/Google_logo.png', height: 20),
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Text(
          _isSigning ? 'Signing in...' : 'Continue with Google',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      appBar: AppBar(
        title: const Text('Welcome'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Text(
                'Sign in to save progress and access personalized features.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Expanded(
                child: Center(
                  child: _currentUser == null
                      ? _buildSignInButton()
                      : _buildSignedIn(),
                ),
              ),
              if (_error != null) ...[
                Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Privacy & Terms',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
