// views/Admin/indexA.dart
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PacienteReport extends StatelessWidget {  // o StatefulWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(child: Text('Panel de Administrador')),
    );
  }
}

class ReportePaciente extends StatelessWidget {
  final int pacienteId;

  const ReportePaciente({Key? key, required this.pacienteId}) : super(key: key);

  Future<void> _generarPDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Reporte del Paciente con ID: $pacienteId'),
        ),
      ),
    );

    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/reporte_paciente_$pacienteId.pdf');
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF generado en: ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al generar PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte del Paciente'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _generarPDF(context),
          child: const Text('Generar PDF'),
        ),
      ),
    );
  }
}