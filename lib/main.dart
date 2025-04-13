import 'package:flutter/material.dart';
import 'Views/Auth/login.dart';
import 'Views/Admin/indexA.dart';
import 'Views/Doctor/indexD.dart';
import 'Views/Paciente/indexP.dart';
import 'Views/Reports/paciente.dart';
import 'Layouts/App.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrack',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => App(), // Layout principal
        '/login': (context) => Login(), // login
        '/Admin/indexA': (context) => IndexA(), // Dashboard administrador
        '/Doctor/indexD': (context) => IndexD(), // Dashboard doctor
        '/Paciente/indexP': (context) => IndexP(), // Dashboard paciente
        '/Reports/paciente': (context) => PacienteReport(), // Reportes PDF
      },
      onGenerateRoute: (settings) {
        // Manejo de rutas no definidas
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('Ruta no encontrada')),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}