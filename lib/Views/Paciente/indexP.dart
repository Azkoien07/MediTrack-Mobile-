import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class IndexP extends StatefulWidget {
  // Cambia de StatelessWidget a StatefulWidget
  const IndexP({Key? key}) : super(key: key);

  @override
  _IndexPState createState() => _IndexPState(); // Aquí creas el estado correspondiente
}

class _IndexPState extends State<IndexP> {
  // Aquí creas el estado para IndexP
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  // Datos del formulario
  TimeOfDay? _horaCita;
  String? _sede;
  String? _especialidad;
  String? _motivo;
  String? _doctor;

  final List<String> sedes = [
    "Autopista Sur",
    "Av 1 de Mayo",
    "Calle 134 Plan Complementario",
    "Calle 145 Plan Complementario",
    "Calle 153 Plan Complementario",
    "Calle 26",
    "Calle 42",
    "Calle 94 Plan Complementario",
    "Carrera 69",
    "Centro Mayor",
    "Fontibón",
    "IPS San Martin - Galán",
    "Kennedy I",
    "Proyecto NQ5 67",
    "Proyecto Torres de Galicia",
    "Sede Empresarial",
    "Suba",
  ];

  final List<String> especialidades = [
    "Pediatría",
    "Psiquiatría",
    "Cardiología",
    "Dermatología",
    "Oftalmología",
    "Neurología",
    "Oncología",
    "Odontología",
  ];

  final List<String> doctores = ["Dra. Pérez", "Dr. Gómez", "Dr. Rodríguez"];

  @override
  void initState() {
    super.initState();
    // Inicializa el formato de fecha para español
    initializeDateFormatting('es_ES', null);
  }

  void _openModal(DateTime selectedDate) {
    // Fija la fecha seleccionada sin modificar la hora
    setState(
      () =>
          _selectedDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
          ),
    );

    // Variable local para la hora en el contexto del modal
    TimeOfDay? horaTemp = _horaCita;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Para que no ocupe toda la pantalla
                    children: [
                      Text(
                        'Agendar Cita Médica\n${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Motivo'),
                        onChanged: (val) => _motivo = val,
                        validator: (val) => val!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Sede'),
                        items:
                            sedes
                                .map(
                                  (sede) => DropdownMenuItem(
                                    value: sede,
                                    child: Text(sede),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => _sede = val,
                        validator:
                            (val) => val == null ? 'Selecciona una sede' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Especialidad',
                        ),
                        items:
                            especialidades
                                .map(
                                  (esp) => DropdownMenuItem(
                                    value: esp,
                                    child: Text(esp),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => _especialidad = val,
                        validator:
                            (val) =>
                                val == null
                                    ? 'Selecciona una especialidad'
                                    : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Doctor'),
                        items:
                            doctores
                                .map(
                                  (doc) => DropdownMenuItem(
                                    value: doc,
                                    child: Text(doc),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) => _doctor = val,
                        validator:
                            (val) =>
                                val == null ? 'Selecciona un doctor' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text("Hora: "),
                          Text(horaTemp?.format(context) ?? "No seleccionada"),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                context: context,
                                initialTime: horaTemp ?? TimeOfDay.now(),
                              );
                              if (picked != null) {
                                // Actualiza solo el estado interno del modal
                                setModalState(() {
                                  horaTemp = picked;
                                });
                              }
                            },
                            child: const Text("Seleccionar Hora"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Actualiza _horaCita justo antes de enviar el formulario
                          _horaCita = horaTemp;
                          _submitForm();
                        },
                        child: const Text("Guardar Cita"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _horaCita != null) {
      Navigator.pop(context); // Cierra modal
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("¡Cita Agendada!"),
              content: const Text("Tu cita fue registrada correctamente."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Aceptar"),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Esto elimina la flecha de regreso
        title: const Text("MediTrack - Panel Paciente"),
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F2FE), Color(0xFFEDE9FE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(blurRadius: 10, color: Colors.black12),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Bienvenido, Paciente",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Aquí puedes gestionar tus citas médicas y consultar tu historial.",
                  ),
                  const SizedBox(height: 20),
                  TableCalendar(
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: DateTime.now(),
                    locale: 'es_ES',
                    onDaySelected: (selected, focused) {
                      if (!selected.isBefore(
                        DateTime.now().subtract(const Duration(days: 1)),
                      )) {
                        _openModal(selected);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No puedes agendar citas en el pasado",
                            ),
                          ),
                        );
                      }
                    },
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _openModal(DateTime.now()),
                    child: const Text("Agendar Nueva Cita"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
