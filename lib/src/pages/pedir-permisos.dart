import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'acept-permisos.dart'; // Importa la pantalla AceptPermisosScreen

class PedirPermisosScreen extends StatefulWidget {
  @override
  _PedirPermisosScreenState createState() => _PedirPermisosScreenState();
}

class _PedirPermisosScreenState extends State<PedirPermisosScreen> {
  String _selectedDate = "2024-12-26";
  String _horaSalida = "5:21 PM";
  String _horaLlegada = "5:21 PM";
  String _motivoSeleccionado = "";
  double _chipSizePersonal = 1.0;
  double _chipSizeSalud = 1.0;
  double _chipSizeEstudio = 1.0;
  double _chipSizeLaboral = 1.0;

  // Método para seleccionar una fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // Método para seleccionar una hora
  Future<void> _selectTime(BuildContext context, bool isSalida) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        final String formattedTime = picked.format(context);
        if (isSalida) {
          _horaSalida = formattedTime;
        } else {
          _horaLlegada = formattedTime;
        }
      });
    }
  }

  // Método para seleccionar un motivo
  void _selectMotivo(String motivo) {
    setState(() {
      _motivoSeleccionado = motivo;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Motivo seleccionado: $motivo")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
        title: const Text("Solicitud de Permiso"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fecha y horas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: _buildInputCard(
                    icon: Icons.calendar_today,
                    label: "Fecha Salida",
                    value: _selectedDate,
                    color: Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectTime(context, true),
                  child: _buildInputCard(
                    icon: Icons.access_time,
                    label: "Hora Salida",
                    value: _horaSalida,
                    color: Colors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectTime(context, false),
                  child: _buildInputCard(
                    icon: Icons.access_time,
                    label: "Hora Llegada",
                    value: _horaLlegada,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Motivos
            const Text(
              "Motivo de Permiso",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _chipSizePersonal = 1.2; // Aumenta el tamaño cuando pasa el mouse
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _chipSizePersonal = 1.0; // Vuelve al tamaño normal
                    });
                  },
                  child: GestureDetector(
                    onTap: () => _selectMotivo("Personal"),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(_chipSizePersonal),
                      child: _buildChip("Personal", Icons.bedtime, Colors.red),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _chipSizeSalud = 1.2;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _chipSizeSalud = 1.0;
                    });
                  },
                  child: GestureDetector(
                    onTap: () => _selectMotivo("Salud"),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(_chipSizeSalud),
                      child: _buildChip("Salud", Icons.health_and_safety, Colors.green),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _chipSizeEstudio = 1.2;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _chipSizeEstudio = 1.0;
                    });
                  },
                  child: GestureDetector(
                    onTap: () => _selectMotivo("Estudio"),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(_chipSizeEstudio),
                      child: _buildChip("Estudio", Icons.book, Colors.blue),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _chipSizeLaboral = 1.2;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _chipSizeLaboral = 1.0;
                    });
                  },
                  child: GestureDetector(
                    onTap: () => _selectMotivo("Laboral"),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(_chipSizeLaboral),
                      child: _buildChip("Laboral", Icons.work, const Color.fromARGB(255, 240, 126, 12)),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Botón de enviar
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (_motivoSeleccionado.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Por favor, selecciona un motivo")),
                    );
                    return;
                  }
                  // Acción para enviar el permiso y navegar a AceptPermisosScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AceptPermisosScreen(
                        motivo: _motivoSeleccionado,
                        fecha: _selectedDate,
                        horaSalida: _horaSalida,
                        horaLlegada: _horaLlegada,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.send),
                label: const Text(
                  "Enviar Solicitud",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para tarjetas de entrada (fecha/hora)
  Widget _buildInputCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para los chips de motivo
  Widget _buildChip(String label, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 18),
      label: Text(label),
      backgroundColor: color,
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}




