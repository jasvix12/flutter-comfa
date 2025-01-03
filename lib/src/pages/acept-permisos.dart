import 'package:flutter/material.dart';
import 'pedir-permisos.dart'; // Importa la pantalla pedir-permisos.dart
import 'login_screen.dart'; // Asegúrate de importar la pantalla de login

class AceptPermisosScreen extends StatefulWidget {
  @override
  _AceptPermisosScreenState createState() => _AceptPermisosScreenState();
}

class _AceptPermisosScreenState extends State<AceptPermisosScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> solicitudesAprobadas = [];
  List<Map<String, String>> nuevasSolicitudes = []; // Usamos una lista para almacenar múltiples solicitudes

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Permisos Comfacauca"),
        leading: GestureDetector(
          onTap: () {
    
          },
          child: Image.asset('assets/images/comlogo.png'), // Solo el logo
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              _showLogoutDialog(context); // Mostrar cuadro de diálogo para confirmar cierre de sesión
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 7, 141, 7),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Pestaña de solicitudes
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (nuevasSolicitudes.isNotEmpty)
                ...nuevasSolicitudes.map((solicitud) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: const Icon(Icons.add_box, color: Colors.green),
                      title: Text("Nueva solicitud: ${solicitud["motivo"]}"),
                      subtitle: Text(
                          "Fecha: ${solicitud["fecha"]}, Hora Salida: ${solicitud["horaSalida"]}, Hora Llegada: ${solicitud["horaLlegada"]}"),
                      onTap: () {
                        _showSolicitudDialog(context, solicitud); // Pasa la solicitud al diálogo
                      },
                    ),
                  );
                }).toList()
              else
                const Center(
                  child: Text(
                    "No hay nuevas solicitudes",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
            ],
          ),
          // Pestaña de solicitudes aprobadas
          ListView(
            padding: const EdgeInsets.all(16),
            children: solicitudesAprobadas.isEmpty
                ? const [
                    Center(
                      child: Text("No hay solicitudes aprobadas",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ),
                  ]
                : solicitudesAprobadas.map((solicitud) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: const Icon(Icons.check, color: Colors.green),
                        title: Text(solicitud),
                      ),
                    );
                  }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PedirPermisosScreen(),
            ),
          );

          if (result != null && result is Map<String, String>) {
            setState(() {
              nuevasSolicitudes.add(result); // Agrega la nueva solicitud a la lista
            });
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.green.withOpacity(0.7),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.book), text: "Solicitudes"),
            Tab(icon: Icon(Icons.check), text: "Aprobadas"),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
    );
  }

  void _showSolicitudDialog(BuildContext context, Map<String, String> solicitud) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Nueva solicitud de permiso"),
      content: const Text("¿Quieres aceptar esta solicitud de permiso?"),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              nuevasSolicitudes.remove(solicitud); // Elimina la solicitud de la lista
            });
            Navigator.pop(context); // Cierra el cuadro de diálogo
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Color de fondo rojo para rechazar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
            ),
          ),
          child: const Text(
            "Rechazar",
            style: TextStyle(color: Colors.white), // Texto blanco
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              solicitudesAprobadas.add("Permiso aprobado para ${solicitud["motivo"]}"); // Agrega la solicitud aprobada
              nuevasSolicitudes.remove(solicitud); // Elimina la solicitud de la lista de nuevas solicitudes
            });
            Navigator.pop(context); // Acepta la solicitud y cierra el cuadro de diálogo
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, // Color de fondo verde para aceptar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
            ),
          ),
          child: const Text(
            "Aceptar",
            style: TextStyle(color: Colors.white), // Texto blanco
          ),
        ),
      ],
    ),
  );
}


  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
        ),
        backgroundColor: Colors.white, // Fondo blanco para el diálogo
        title: const Text(
          'Cerrar sesión',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.redAccent, // Color para el título
          ),
        ),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión?',
          style: TextStyle(color: Colors.black87), // Color del texto
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo sin hacer nada
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 244, 19, 19), // Fondo gris para el botón de Cancelar
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                    ),
                  ),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // Redirigir al login
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Fondo verde para el botón de Aceptar
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
                    ),
                  ),
                  child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
