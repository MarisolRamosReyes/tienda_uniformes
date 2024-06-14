import 'package:flutter/material.dart';
import 'package:tienda_uniformes/menu.dart';
import 'package:tienda_uniformes/register.dart';

void main() {
  runApp(const Login());
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Inicio de sesión',),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  void _login(){
    if (_user.text == "lola" && _pass.text == "1234") {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const Menu()), (Route<dynamic> route) => false);
    }
    else{
      showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("Sigue intentedo"),
        content: const Text("Te has equivocado, parguela"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _user,
              decoration: const InputDecoration(
                labelText: 'Usuario o Correo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0), 
            TextField(
              controller: _pass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            const SizedBox(height: 24.0),
            const Text("Aun no tienes cuenta?"), TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> const Register()));}, child: const Text("Registrate")),
          ],
        ),
      ),
    );
  }
}
