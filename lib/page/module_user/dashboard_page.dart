import 'package:flutter/material.dart';
import 'package:medical_app/page/module_user/obat_page.dart';
import 'package:medical_app/page/module_user/profile_page.dart';

class DasboardPage extends StatefulWidget {
  const DasboardPage({Key? key}) : super(key: key);

  @override
  State<DasboardPage> createState() => _DasboardPageState();
}

class _DasboardPageState extends State<DasboardPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: _getBodyWidget(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (value) => setState(() => currentIndex = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.medication_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Doctor',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getBodyWidget() {
    switch (currentIndex) {
      case 0:
        return const ObatPage();
      case 1:
        return const Center(child: Text('Search Content'));
      case 2:
        return const ProfilePage();
      default:
        return Container();
    }
  }
}
