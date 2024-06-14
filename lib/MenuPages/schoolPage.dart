import 'package:flutter/material.dart';
import 'package:tienda_uniformes/Models/School.dart';
/* import 'package:tienda_uniformes/login.dart'; */
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  late Future<List<School>> _listadoSchools;

  Future<List<School>> _getSchools() async{
    try {
      final uri = Uri.parse("http://192.168.1.157:5191/api/School/GetSchool?IdU=1");
      final response = await get(uri, headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },);
      //192.168.100.16:7033 //192.168.7.165 //:5191 //https://127.0.0.1:7033/swagger/index.html
      if (response.statusCode == 200) {
        print(response.body);
        List<School> school = [];
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        
        for (var item in jsonData["data"]) {
          school.add(School(idSc: item["idSc"] , name: item["name"].toString()));
        }
        return school;
      }
      else {
        throw Exception("Fallo la conexion");
      }
      } on SocketException {
      throw Exception("Sin conexión a Internet");
    } catch (e) {
      throw Exception("Ocurrió un error: $e");
    }
  }

  Future<http.Response> get(Uri uri, {required Map<String, String> headers}) => http.get(uri);

  final List<School> _schools = [
    School(idSc: 1, name: "Lazaro Cardenas", ),
    School(idSc: 2, name: "Venustiano Carranza"),
    School(idSc: 3, name: "Santiago de la Republica"),
    School(idSc: 4, name: "Benito Juarez")
  ];

  @override
  void initState() {
    super.initState();
    _listadoSchools = _getSchools();
    /*print(_listadoSchools); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(28.0),
            itemCount: _schools.length,
            itemBuilder: (BuildContext context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    _editarDato(context, _schools[index]);
                  },
                  title: Text(_schools[index].data().toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _borrarDato(context, _schools[index]);
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {_nuevoDato(context);},
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  _borrarDato(context, School school){
    showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text("Eliminar campo"),
        content: Text("¿Estas seguro de que deseas eliminar a ${school.name}?"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Cancelar"),
          ),
          TextButton(onPressed: (){
            setState(() {
              _schools.remove(school);
            });
            Navigator.pop(context);
          }, child: const Text("Borrar", style: TextStyle(color: Colors.red),),
          )
        ],
    ));
  }

  _editarDato(context, School school){
    final TextEditingController name = TextEditingController(text: school.name);
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Editar Campo"),
      content: TextField(
        controller: name,
        decoration: const InputDecoration(
          labelText: 'Nombre de la escuela',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
        ),
        TextButton(onPressed: (){
          setState(() {
            school.name = name.text;
          });
          Navigator.pop(context);
        }, child: const Text("Editar",),
        )
      ],
    ));
  }

  _nuevoDato(context){
    final TextEditingController name = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      title: const Text("Nuevo Campo"),
      content: TextField(
        controller: name,
        decoration: const InputDecoration(
          labelText: 'Nombre de la escuela',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
        ),
        TextButton(onPressed: (){
          setState(() {
            int newId = _schools.isNotEmpty ? _schools.map((school) => school.idSc).reduce((a, b) => a > b ? a : b) + 1 : 1;
                _schools.add(School(idSc: newId, name: name.text));
          });
          Navigator.pop(context);
        }, child: const Text("Nuevo", style: TextStyle(color: Colors.green)),
        )
      ],
    ));
  }
}
