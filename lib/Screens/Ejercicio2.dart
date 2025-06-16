import 'package:flutter/material.dart';

class Ejercicio2 extends StatefulWidget {
  const Ejercicio2({super.key});

  @override
  State<Ejercicio2> createState() => _Ejercicio2State();
}

class _Ejercicio2State extends State<Ejercicio2> {
  final TextEditingController _nombreMateriaController = TextEditingController();
  final TextEditingController _notaController = TextEditingController();

  Estudiante estudiante = Estudiante();
  Materia? materiaActual;
  String mensaje = "";

  void agregarMateria() {
    String nombre = _nombreMateriaController.text.trim();
    if (nombre.isEmpty) return;

    setState(() {
      materiaActual = Materia(nombre: nombre);
      estudiante.agregarMateria(materiaActual!);
      _nombreMateriaController.clear();
      mensaje = "Materia '$nombre' creada.";
    });
  }

  void agregarNota() {
    if (materiaActual == null) {
      setState(() {
        mensaje = "Primero crea una materia.";
      });
      return;
    }

    double? nota = double.tryParse(_notaController.text);
    if (nota == null || nota < 0 || nota > 10) {
      setState(() {
        mensaje = "Ingresa una nota válida (0 a 10).";
      });
      return;
    }

    setState(() {
      materiaActual!.agregarNota(nota);
      _notaController.clear();
      mensaje = "Nota agregada.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EJERCICIO 2")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("PROMEDIOS", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            // Campo para crear materia
            TextField(
              controller: _nombreMateriaController,
              decoration: const InputDecoration(labelText: "Nombre de la materia"),
            ),
            ElevatedButton(onPressed: agregarMateria, child: const Text("Crear Materia")),

            const SizedBox(height: 20),

            // Campo para agregar nota
            TextField(
              controller: _notaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Agregar nota (0 a 10)"),
            ),
            ElevatedButton(onPressed: agregarNota, child: const Text("Agregar Nota")),

            const SizedBox(height: 20),
            Text(mensaje, style: const TextStyle(color: Colors.blue)),

            const Divider(height: 30),

            const Text("Materias del estudiante:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: estudiante.materias.map((m) {
                return Text(m.mostrarInformacion());
              }).toList(),
            ),

            const SizedBox(height: 20),
            Text(
              "Promedio general del estudiante: ${estudiante.promedioGeneral().toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Lógica del ejercicio -------------

class Materia {
  String nombre;
  List<double> notas = [];

  Materia({required this.nombre});

  void agregarNota(double nota) {
    notas.add(nota);
  }

  double calcularPromedio() {
    if (notas.isEmpty) return 0.0;
    return notas.reduce((a, b) => a + b) / notas.length;
  }

  String mostrarInformacion() {
    return "Materia: $nombre | Promedio: ${calcularPromedio().toStringAsFixed(2)}";
  }
}

class Estudiante {
  List<Materia> materias = [];

  void agregarMateria(Materia materia) {
    materias.add(materia);
  }

  double promedioGeneral() {
    if (materias.isEmpty) return 0.0;
    double suma = 0.0;
    for (var m in materias) {
      suma += m.calcularPromedio();
    }
    return suma / materias.length;
  }
}
