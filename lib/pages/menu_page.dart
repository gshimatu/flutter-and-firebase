import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  User? _currentUser;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _logout() async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.blue[700],
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Se Déconnecter',
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.userCheck,
                size: 100,
                color: Colors.blue[700],
              ),
              const SizedBox(height: 20),
              Text(
                'Bienvenue !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Connecté en tant que : ${_currentUser?.email ?? 'Utilisateur'}',
                style: TextStyle(fontSize: 18, color: Colors.blue[800]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              // Ici, on ajoutera plus tard les fonctionnalités d'ajout et de liste des produits
              Text(
                'Fonctionnalités à venir : Gestion des Produits',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[600],
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
