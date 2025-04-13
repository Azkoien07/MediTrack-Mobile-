// views/Admin/indexA.dart
import 'package:flutter/material.dart';

class PacienteReport extends StatelessWidget {  // o StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(child: Text('Panel de Administrador')),
    );
  }
}