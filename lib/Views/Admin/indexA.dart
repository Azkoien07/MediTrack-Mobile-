import 'package:flutter/material.dart';

class IndexA extends StatelessWidget {
  // Datos de ejemplo (esto debería venir de una API o base de datos)
  final int pacientesCount = 120;
  final int doctoresCount = 45;
  final int especialidadesCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F8FF), // Fondo suave azul claro
      appBar: AppBar(
        automaticallyImplyLeading: false, // Esto elimina la flecha de regreso
        title: const Text("MediTrack - Panel Doctor"),
        backgroundColor: Colors.blue.shade700,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/login',
              ); // Redirige al login
            },
            child: const Text(
              "Cerrar Sesión",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Text(
                  'Panel de Administración',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
                SizedBox(height: 20),

                // Tarjetas de información
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Si la pantalla es pequeña, apilamos las tarjetas
                    return constraints.maxWidth > 600
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCard(
                          'Pacientes Registrados',
                          pacientesCount,
                          Color(0xFF81C784),
                        ), // Verde suave
                        _buildCard(
                          'Doctores Registrados',
                          doctoresCount,
                          Color(0xFF64B5F6),
                        ), // Azul claro
                        _buildCard(
                          'Especialidades Médicas',
                          especialidadesCount,
                          Color(0xFF9575CD),
                        ), // Morado suave
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCard(
                          'Pacientes Registrados',
                          pacientesCount,
                          Color(0xFF81C784),
                        ), // Verde suave
                        SizedBox(height: 16),
                        _buildCard(
                          'Doctores Registrados',
                          doctoresCount,
                          Color(0xFF64B5F6),
                        ), // Azul claro
                        SizedBox(height: 16),
                        _buildCard(
                          'Especialidades Médicas',
                          especialidadesCount,
                          Color(0xFF9575CD),
                        ), // Morado suave
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),

                // Tabla de Pacientes
                Text(
                  'Lista de Pacientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
                SizedBox(height: 10),
                _buildTable(),

                // Tabla de Doctores
                SizedBox(height: 20),
                Text(
                  'Lista de Doctores',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A90E2),
                  ),
                ),
                SizedBox(height: 10),
                _buildDoctorTable(),
              ],
            ),
          );
        },
      ),
    );
  }

  // Tarjetas de información
  Widget _buildCard(String title, int count, Color color) {
    return Container(
      width:
      double
          .infinity, // Hacemos que la tarjeta ocupe todo el ancho disponible
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Tabla de pacientes (solo un ejemplo de tabla estática)
  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Correo')),
            DataColumn(label: Text('Fecha Registro')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('1')),
                DataCell(Text('paciente@correo.com')),
                DataCell(Text('01/01/2021')),
                DataCell(
                  Builder(
                    builder: (BuildContext context) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Simular descarga de reporte
                              print('Descargando reporte del paciente con ID 1');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Reporte descargado')),
                              );
                            },
                            child: const Text('Descargar Reporte'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF64B5F6),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              print('Editar paciente ID 1');
                              Navigator.pushNamed(
                                context,
                                '/editar-paciente',
                                arguments: {'id': 1}, 
                              );
                            },
                            child: const Text('Editar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFEB3B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              _showEliminarDialog(context, 'paciente', 1);
                            },
                            child: const Text('Eliminar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE57373),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            // Agregar más filas según los datos
          ],
        ),
      ),
    );
  }

  // Tabla de doctores (con un ejemplo simple)
  Widget _buildDoctorTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Correo')),
            DataColumn(label: Text('Especialidad')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: [
            DataRow(
              cells: [
                DataCell(Text('1')),
                DataCell(Text('doctor@correo.com')),
                DataCell(Text('Cardiología')),
                DataCell(
                  Builder(
                    builder: (BuildContext context) {
                      return Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('Asignar especialidad a doctor ID 1');
                              Navigator.pushNamed(
                                context,
                                '/asignar-especialidades',
                                arguments: {'id': 1}, // Cambiado a Map con clave 'id'
                              );
                            },
                            child: const Text('Asignar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF64B5F6),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              print('Editar doctor ID 1');
                              Navigator.pushNamed(
                                context,
                                '/editar-doctor',
                                arguments: {'id': 1}, // Cambiado a Map con clave 'id'
                              );
                            },
                            child: const Text('Editar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFEB3B),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              _showEliminarDialog(context, 'doctor', 1);
                            },
                            child: const Text('Eliminar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE57373),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),

            // Agregar más filas según los datos
          ],
        ),
      ),
    );
  }

  void _showEliminarDialog(BuildContext context, String tipo, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar $tipo'),
          content: Text('¿Estás seguro de que deseas eliminar este $tipo con ID $id?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Lógica para eliminar el elemento
                print('$tipo con ID $id eliminado');
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$tipo eliminado correctamente')),
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
