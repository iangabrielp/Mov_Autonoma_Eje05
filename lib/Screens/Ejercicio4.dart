import 'package:flutter/material.dart';

class Ejercicio4 extends StatefulWidget {
  const Ejercicio4({super.key});

  @override
  State<Ejercicio4> createState() => _Ejercicio4State();
}

class _Ejercicio4State extends State<Ejercicio4> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _autorController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _buscarTituloController = TextEditingController();

  List<Libro> biblioteca = [];
  List<Libro> resultadosBusqueda = [];
  String mensaje = "";

  void agregarLibro() {
    String titulo = _tituloController.text.trim();
    String autor = _autorController.text.trim();
    int? anio = int.tryParse(_anioController.text.trim());
    int? cantidad = int.tryParse(_cantidadController.text.trim());

    if (titulo.isEmpty || autor.isEmpty || anio == null || cantidad == null) {
      setState(() {
        mensaje = "Por favor llena todos los campos correctamente.";
      });
      return;
    }

    setState(() {
      biblioteca.add(Libro(
        titulo: titulo,
        autor: autor,
        anioPublicacion: anio,
        cantidadDisponible: cantidad,
      ));
      mensaje = "Libro '$titulo' agregado exitosamente.";
      _tituloController.clear();
      _autorController.clear();
      _anioController.clear();
      _cantidadController.clear();
    });
  }

  void buscarLibro() {
    String titulo = _buscarTituloController.text.trim().toLowerCase();
    setState(() {
      resultadosBusqueda = biblioteca
          .where((libro) => libro.titulo.toLowerCase().contains(titulo))
          .toList();

      mensaje = resultadosBusqueda.isEmpty
          ? "No se encontraron libros con ese título."
          : "Se encontraron ${resultadosBusqueda.length} resultado(s).";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EJERCICIO 4")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("LIBRO", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),

            const Text("Agregar nuevo libro", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _tituloController, decoration: const InputDecoration(labelText: "Título")),
            TextField(controller: _autorController, decoration: const InputDecoration(labelText: "Autor")),
            TextField(controller: _anioController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Año de publicación")),
            TextField(controller: _cantidadController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Cantidad disponible")),
            ElevatedButton(onPressed: agregarLibro, child: const Text("Agregar Libro")),

            const SizedBox(height: 20),
            const Text("Buscar libro por título", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: _buscarTituloController, decoration: const InputDecoration(labelText: "Buscar título")),
            ElevatedButton(onPressed: buscarLibro, child: const Text("Buscar")),

            const SizedBox(height: 20),
            Text(mensaje, style: const TextStyle(color: Colors.blue)),
            const Divider(height: 30),

            const Text("Resultados de búsqueda / Biblioteca:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (resultadosBusqueda.isNotEmpty ? resultadosBusqueda : biblioteca)
                  .map((libro) => Text(libro.mostrarInformacion()))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Clase Libro -------------

class Libro {
  String titulo;
  String autor;
  int anioPublicacion;
  int cantidadDisponible;

  Libro({
    required this.titulo,
    required this.autor,
    required this.anioPublicacion,
    required this.cantidadDisponible,
  });

  String mostrarInformacion() {
    return "Título: $titulo | Autor: $autor | Año: $anioPublicacion | Disponibles: $cantidadDisponible";
  }
}
