import 'dart:async';
import 'package:flutter/material.dart';

class AsignarEspecialidades extends StatefulWidget {
  final int doctorId;

  const AsignarEspecialidades({Key? key, required this.doctorId}) : super(key: key);

  @override
  _AsignarEspecialidadesState createState() => _AsignarEspecialidadesState();
}

class _AsignarEspecialidadesState extends State<AsignarEspecialidades> {
  final _formKey = GlobalKey<FormState>();
  String? especialidadSeleccionada;

  @override
  Widget build(BuildContext context) {
    // Simular lista de especialidades
    final List<String> especialidades = [
      'Cardiología',
      'Pediatría',
      'Dermatología',
      'Neurología',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignar Especialidades'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Asignar Especialidad al Doctor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Seleccionar Especialidad',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: especialidades.map((especialidad) {
                        return DropdownMenuItem(
                          value: especialidad,
                          child: Text(especialidad),
                        );
                      }).toList(),
                      value: especialidadSeleccionada,
                      onChanged: (value) {
                        setState(() {
                          especialidadSeleccionada = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor seleccione una especialidad';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Lógica para guardar la especialidad seleccionada
                            print('Especialidad $especialidadSeleccionada asignada al doctor con ID ${widget.doctorId}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Especialidad "$especialidadSeleccionada" asignada correctamente')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Asignar Especialidad',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}