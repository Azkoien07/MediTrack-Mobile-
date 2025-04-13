import 'package:flutter/material.dart';

void main() => runApp(IndexD());

class IndexD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panel del Doctor',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF9FAFB), // bg-gray-50
        primaryColor: Color(0xFF2563EB), // blue-600
        colorScheme: ColorScheme.light(
          secondary: Color(0xFFEF4444), // red-600
          onSecondary: Colors.white,
        ),
      ),
      home: DoctorDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  bool _showAppointments = false;
  final List<Map<String, String>> _appointments = [
    {'fecha': '2023-05-15', 'hora': '09:00', 'sede': 'Central', 'estado': 'Confirmada'},
    {'fecha': '2023-05-16', 'hora': '11:30', 'sede': 'Norte', 'estado': 'Pendiente'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctor',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {}, // Configuración
            child: Text(
              'Configuración',
              style: TextStyle(color: Color(0xFF374151)), // gray-700
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {}, // Cerrar sesión
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
            ),
            child: Text('Cerrar Sesión'),
          ),
          SizedBox(width: 16),
        ],
        elevation: 4,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 672), // max-w-2xl
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12)),
                          ),
                          child: Text(
                            'Bienvenido, Doctor',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aquí puedes gestionar tus pacientes, citas y más.',
                                style: TextStyle(
                                  color: Color(0xFF374151)), // gray-700
                              SizedBox(height: 24),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _showAppointments = !_showAppointments;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    ),
                                    child: Text('Ver Citas'),
                                  ),
                                  SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: () {}, // Ver pacientes
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF16A34A), // green-600
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 8),
                                    ),
                                    child: Text('Ver Pacientes'),
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
              ),
            ),
          ),
          if (_showAppointments) _buildAppointmentsTable(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '© 2025 MediTrack. Todos los derechos reservados.',
            style: TextStyle(color: Color(0xFF4B5563)), // gray-600
        ),
      ),
    ),
    );
  }

  Widget _buildAppointmentsTable() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Tus Citas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Color(0xFFD1D5DB)), // gray-300
            ),
            child: _appointments.isEmpty
                ? Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'No tienes citas registradas.',
                        style: TextStyle(color: Color(0xFF6B7280)), // gray-500
                      ),
                    ),
                  )
                : Table(
                    border: TableBorder.all(color: Color(0xFFD1D5DB)), // gray-300
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                        children: [
                          _buildHeaderCell('Fecha'),
                          _buildHeaderCell('Hora'),
                          _buildHeaderCell('Sede'),
                          _buildHeaderCell('Estado'),
                        ],
                      ),
                      ..._appointments.map((appointment) => TableRow(
                            children: [
                              _buildCell(appointment['fecha']!),
                              _buildCell(appointment['hora']!),
                              _buildCell(appointment['sede']!),
                              _buildCell(appointment['estado']!),
                            ],
                          )),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}