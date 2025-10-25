import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/routes.dart';
import 'package:my_app/config/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Stream<User?> _authStream;

  @override
  void initState() {
    super.initState();
    _authStream = FirebaseAuth.instance.authStateChanges();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authStream.first.then((user) async {
        if (!mounted) return;
        if (user == null) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          return;
        }
        try {
          final snap = await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
          final data = snap.data();
          final role = data != null ? (data['role'] as String?) : null;
          final isAdmin = role == 'admin';
          Navigator.of(context).pushReplacementNamed(
            isAdmin ? AppRoutes.admin : AppRoutes.home,
          );
        } catch (_) {
          // On error, default to customer home
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 12),
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
