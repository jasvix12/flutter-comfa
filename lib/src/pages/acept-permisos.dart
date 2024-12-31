import 'package:flutter/material.dart';
import 'pedir-permisos.dart'; // Importa la pantalla pedir-permisos.dart
import 'login_screen.dart'; // Asegúrate de importar la pantalla de login

class AceptPermisosScreen extends StatefulWidget {
  final String motivo;
  final String fecha;
  final String horaSalida;
  final String horaLlegada;

  AceptPermisosScreen({
    required this.motivo,
    required this.fecha,
    required this.horaSalida,
    required this.horaLlegada,
  });

  @override
  _AceptPermisosScreenState createState() => _AceptPermisosScreenState();
}

class _AceptPermisosScreenState extends State<AceptPermisosScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
            _showLogoutDialog(context); // Mostrar el cuadro de diálogo cuando se presiona el logo
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
        backgroundColor: const Color.fromARGB(255, 166, 235, 102),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.add_box, color: Colors.green),
                  title: const Text("Nueva solicitud de permiso"),
                  onTap: () {
                    // Acción para abrir la solicitud
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              "Motivo: ${widget.motivo}\nFecha: ${widget.fecha}\nHora de Salida: ${widget.horaSalida}\nHora de Llegada: ${widget.horaLlegada}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateWithAnimation(context); // Navegación con animación
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

  // Método para mostrar el cuadro de diálogo de logout
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

  // Método para navegar con animación
  void _navigateWithAnimation(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => PedirPermisosScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
  }
}














