// Views/Doctor/indexD.dart - Implementación corregida
import 'package:flutter/material.dart';

class IndexD extends StatefulWidget {
  const IndexD({Key? key}) : super(key: key);

  @override
  State<IndexD> createState() => _IndexDState();
}

class _IndexDState extends State<IndexD> {
  bool _mostrarCitas = false;
  bool _mostrarPacientes = false; // ✅ Agregado
  final List<Map<String, String>> _citas = [];
  final List<Map<String, String>> _pacientes = [
    {'nombre': 'Juan Pérez', 'edad': '30', 'especialidad': 'Cardiología'},
    {'nombre': 'María López', 'edad': '25', 'especialidad': 'Pediatría'},
    {'nombre': 'Carlos García', 'edad': '40', 'especialidad': 'Dermatología'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("MediTrack - Panel Doctor"),
        backgroundColor: Colors.blue.shade700,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
            },
            child: const Text(
              "Cerrar Sesión",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              // Panel de bienvenida
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Bienvenido, Doctor',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Aquí puedes gestionar tus pacientes, citas y más.',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _mostrarCitas = !_mostrarCitas;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[600],
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    _mostrarCitas
                                        ? 'Ocultar Citas'
                                        : 'Ver Citas',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _mostrarPacientes = !_mostrarPacientes;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600],
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    _mostrarPacientes
                                        ? 'Ocultar Pacientes'
                                        : 'Ver Pacientes',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Panel de citas
              if (_mostrarCitas)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tus Citas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              'No tienes citas registradas.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // ✅ Panel de pacientes
              if (_mostrarPacientes)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tus Pacientes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._pacientes.map((paciente) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paciente['nombre'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Edad: ${paciente['edad']} años",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                                Text(
                                  "Especialidad: ${paciente['especialidad']}",
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
