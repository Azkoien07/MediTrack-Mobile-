// views/Admin/indexA.dart
import 'package:flutter/material.dart';

class IndexP extends StatelessWidget {  // o StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Paciente Dashboard')),
      body: Center(child: Text('Panel del paciente')),
    );
  }
}