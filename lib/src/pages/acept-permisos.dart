import 'package:flutter/material.dart';

class AceptPermisosScreen extends StatefulWidget {
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
        title: Text("Permisos Comfacauca"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              // Acción para cerrar sesión
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 166, 235, 102),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Primera pestaña: Solicitudes de Permiso
          ListView(
            padding: EdgeInsets.all(16),
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.add_box, color: Colors.green),
                  title: Text("Nueva solicitud de permiso"),
                  onTap: () {
                    // Acción para abrir la solicitud
                  },
                ),
              ),
            ],
          ),

          // Segunda pestaña: Aprobadas
          Center(
            child: Text(
              "No hay permisos aprobados",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar nueva solicitud
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Solicitudes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Aprobadas",
          ),
        ],
        onTap: (index) {
          _tabController.animateTo(index); // Cambiar entre las vistas
        },
        currentIndex: _tabController.index,
      ),
    );
  }
}






