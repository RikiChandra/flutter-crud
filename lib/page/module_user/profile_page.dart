import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medical_app/page/login_page.dart';
import 'package:medical_app/util/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String username;
  late String name;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      username = prefs.getString('userName') ?? '';
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        NetworkImage('https://i.ibb.co/QrTHd59/woman.jpg'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const ListTile(
                    leading: Icon(Icons.email),
                    title: Text('johndoe@example.com'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+1234567890'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('123 Street, City, Country'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _logout();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            ),
    );
  }

  void _logout() async {
    final isCleared = await clearSession();
    if (isCleared) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
      log('Session cleared');
    } else {
      log('Error clearing session: $isCleared');
    }
  }
}
