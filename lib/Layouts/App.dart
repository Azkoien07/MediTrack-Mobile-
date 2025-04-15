// Layouts/App.dart
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final Widget child;

  const App({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerHeader(child: Text("Menú")),
            ListTile(title: Text("Inicio")),
          ],
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}
