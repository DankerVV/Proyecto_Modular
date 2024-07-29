import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_markers.dart';

class RutasView extends StatefulWidget {
  const RutasView({super.key});

  @override
  State<RutasView> createState() => _RutasViewState();
}

class _RutasViewState extends State<RutasView> {
  static const initialPosition = LatLng(20.66682, -103.39182);//Posicion inicial en Guadalajara

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context)=> Scaffold(
    body: GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: initialPosition,
        zoom: 12
      ),
      markers:{
        ...estacionesLinea1,
        ...estacionesLinea2,
        ...estacionesLinea3,
      }
    ),
  );
}