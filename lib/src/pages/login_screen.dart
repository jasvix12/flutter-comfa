import 'package:flutter/material.dart';
import 'acept-permisos.dart'; // Importa la pantalla de permisos

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 217, 236, 12), // Fondo verde claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono de perfil en la parte superior
            Image.asset(
              'assets/images/perfil.png', // Ruta del ícono de perfil
              width: 80, // Ajusta el tamaño según lo que necesites
              height: 80,
            ),
            SizedBox(height: 20), // Espaciado entre el ícono y el botón
            // Botón de Google
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Fondo blanco del botón
                foregroundColor: Colors.black, // Texto negro
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Espaciado del botón
              ),
              icon: Image.asset(
                'assets/images/google.png', // Ruta del logo de Google
                width: 24,
                height: 24,
              ),
              label: Text(
                'Iniciar sesión con Google',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navegación a la pantalla de permisos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AceptPermisosScreen(), // Llama a la pantalla de permisos
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




