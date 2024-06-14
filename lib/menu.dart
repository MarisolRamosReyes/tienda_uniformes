import 'package:flutter/material.dart';
import 'package:tienda_uniformes/MenuPages/home.dart';
import 'package:tienda_uniformes/MenuPages/schoolPage.dart';
/* import 'package:tienda_uniformes/main.dart'; */

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _paginaActual = 0;
  final List<Widget> _pages = const [
    Home(),
    SchoolPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_paginaActual],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _paginaActual = index;
          });
        },
        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        ])
    );
  }
}