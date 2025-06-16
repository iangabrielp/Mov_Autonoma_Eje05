import 'package:ejercicios_05/Screens/Ejercicio2.dart';
import 'package:ejercicios_05/Screens/Ejercicio4.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Ejercicio04App());
}

class Ejercicio04App extends StatelessWidget {
  const Ejercicio04App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatefulWidget {
  const Cuerpo({super.key});


  @override
  State<Cuerpo> createState() => _CuerpoState();
}

class _CuerpoState extends State<Cuerpo> {
    int indice = 1;
    List <Widget> paginas=[Ejercicio2(),Ejercicio4()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BOTTOM TAB"),
        ),



      body: paginas[indice],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indice,

        onTap: (value) {
          setState(() {
            indice=value;
          });
        },
        
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.filter_1, color: Color.fromRGBO(223, 8, 73, 1),), label: "Pantalla 1"),
        BottomNavigationBarItem(icon: Icon(Icons.filter_2), label: "Pantalla 2"),
        
      ],),
    );
  }
}
