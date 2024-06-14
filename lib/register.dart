import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  String? validarCorreo(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Por favor ingrese un correo';
    }
    // Expresión regular para validar el correo electrónico
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(valor)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  String? validarContrasena(String? valor) {
    if (valor == null || valor.isEmpty) {
      return 'Por favor ingrese una contraseña';
    }
    if (valor.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    if (!RegExp(r'[A-Z]').hasMatch(valor)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    }
    if (!RegExp(r'[a-z]').hasMatch(valor)) {
      return 'La contraseña debe tener al menos una letra minúscula';
    }
    if (!RegExp(r'\d').hasMatch(valor)) {
      return 'La contraseña debe tener al menos un número';
    }
    if (!RegExp(r'[!@#\$&*~]').hasMatch(valor)) {
      return 'La contraseña debe tener al menos un caracter especial (!@#\$&*~)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController user = TextEditingController();
    final TextEditingController mail = TextEditingController();
    final TextEditingController pass = TextEditingController();
    final TextEditingController passC = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Registro'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: user,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0), 
                TextFormField(
                  controller: mail,
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                  validator: validarCorreo,
                ),
                const SizedBox(height: 16.0), 
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: validarContrasena,
                ),
                const SizedBox(height: 16.0), 
                TextFormField(
                  controller: passC,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != pass.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  child: const Text("Registrar"),
                  onPressed: ()=>{
                    if (formKey.currentState!.validate()) {
                      // Si el formulario es válido, muestra un snackbar o realiza alguna acción
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registro exitoso')),
                      ),
                      Navigator.pop(context),
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}