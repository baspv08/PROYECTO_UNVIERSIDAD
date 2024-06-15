import 'package:flutter/material.dart';
import 'package:aplicacion_esports/services/http_service.dart';

class DetalleEquipoScreen extends StatefulWidget {
  final int equipoId;

  DetalleEquipoScreen({required this.equipoId});

  @override
  _DetalleEquipoScreenState createState() => _DetalleEquipoScreenState();
}

class _DetalleEquipoScreenState extends State<DetalleEquipoScreen> {
  HttpService httpService = HttpService();
  List<dynamic> jugadores = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarJugadores();
  }

  void _cargarJugadores() async {
    try {
      List<dynamic> response = await httpService.obtenerJugadoresPorEquipo(widget.equipoId);
      setState(() {
        jugadores = response;
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar jugadores del equipo: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jugadores del Equipo'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jugadores.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      jugadores[index]['nombre'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(jugadores[index]['posicion']),
                  ),
                );
              },
            ),
    );
  }
}