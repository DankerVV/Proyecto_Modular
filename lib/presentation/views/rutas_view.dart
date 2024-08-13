import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estacion_cercana.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_coordenadas.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_markers.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_polylines.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/genetic_algorithm.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/graph.dart';

class RutasView extends StatefulWidget {
  const RutasView({super.key});

  @override
  State<RutasView> createState() => _RutasViewState();
}

class _RutasViewState extends State<RutasView> {
  final locationController = Location();
  static const initialPosition = LatLng(20.66682, -103.39182);//Posicion inicial en Guadalajara
  LatLng? currentPosition; // Posicion actual que se actualiza seguido
  LatLng? finalPosition; // Para almacenar la posición seleccionada por el usuario
  LatLng? lastStation;
  bool isPlanningRoute = false; // Bandera para controlar el modo de planificación de ruta
  bool _isCalculating = false;
  Set<Polyline> _polylines = {
    ...lineasLinea1,
    ...lineasLinea2,
    ...lineasLinea3,
    ...lineasMacrocalzada,
    ...lineasMacroperiferico
  };
  Set<Marker> _markers = {};

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => await fetchLocationUpdates());//Llamar funcion para pedir ubicacion
  }

  @override
  Widget build(BuildContext context)=> Scaffold(
    body: Stack(
      children: [
        currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: initialPosition,
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('currentLocation'),
                  icon: BitmapDescriptor.defaultMarker,
                  position: currentPosition!,
                ),
                ..._markers,
              },
              polylines: _polylines,
              onTap: isPlanningRoute ? _handleTap : null, // Manejar el evento onTap si se está planificando la ruta
            ),
        Positioned(// Aqui comienza el boton
          bottom: 10,
          left: 100,
          right: 100,
          child: ElevatedButton(
            onPressed: () {
              setState(() {// Activar la bandera para escuchar el tap
                isPlanningRoute = true;
                _polylines = {
                  ...lineasLinea1,
                  ...lineasLinea2,
                  ...lineasLinea3,
                  ...lineasMacrocalzada,
                  ...lineasMacroperiferico
                };
                _markers = {};
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Toque en el mapa su destino')),
              );
            },
            child: const Text('Planear una ruta', style: TextStyle(fontSize: 18),),
          ),
        ),
        if (_isCalculating) const Center(child: CircularProgressIndicator()), 
      ],
      
    ),
  );


  //Solicitar permisos para acceder a la ubicación y acceder a ella de forma continua
  Future<void> fetchLocationUpdates() async{
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationController.serviceEnabled();
    if(serviceEnabled){
      serviceEnabled = await locationController.requestService();
    }
    else{
      return;
    }

    permissionGranted = await locationController.hasPermission();
    if(permissionGranted == PermissionStatus.denied){
      permissionGranted = await locationController.requestPermission();
    }
    if(permissionGranted != PermissionStatus.granted){
      return;
    }

    locationController.onLocationChanged.listen((currentLocation){
      if(currentLocation.latitude != null && 
      currentLocation.longitude != null){
        setState(() {
          currentPosition = LatLng(
            currentLocation.latitude!,
            currentLocation.longitude!
            );
        });
      }
    });
  }

  // escuchar dónde toca la pantalla el usuario y obtener las coordenadas
  void _handleTap(LatLng tappedPoint) {
    setState(() {
      finalPosition = tappedPoint;
      isPlanningRoute = false; // Desactivar bandera después de seleccionar el destino
    });
    print('Destino seleccionado: $finalPosition');
    lastStation = estacionCercana(finalPosition!, estaciones);
    print('Posición Actual: $currentPosition');
    LatLng? firstStation = estacionCercana(currentPosition!, estaciones);
    drawMarkers(firstStation, lastStation);
    findBestRoute(firstStation, lastStation, grafoTransporte);
  }

// hilo aparte para calcular el mejor camino sin que se frene la aplicacion
  Future<void> findBestRoute(LatLng? firstStation, LatLng? lastStation, Graph graph) async {
    if (lastStation != null) {
      setState(() {
        _isCalculating = true; // Muestra el indicador de progreso
      });
      List<LatLng> bestPath = await computeAntColony(firstStation, lastStation, grafoTransporte);// Ejecutar el cálculo en un hilo
      print('MEJOR RUTA: $bestPath');
      drawPath(bestPath);
      setState(() {
        _isCalculating = false; // Ocultar el indicador de progreso
      });
    }
  }
  Future<List<LatLng>> computeAntColony(LatLng? startStation, LatLng? endStation, Graph graph) async {
    return await Future.delayed(const Duration(milliseconds: 100), () {
      return antColony(startStation, endStation, graph);
    });
  }

  // dibujar la mejor ruta encontrada por las hormigas
  void drawPath(List<LatLng> bestPath) {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('bestPath'),
          color: Colors.yellow,
          width: 3,
          points: bestPath,
        ),
      );
    });
  }
  // dibujar los markers de la primera y utlima estacion
  void drawMarkers(LatLng? firstStation, LatLng? lastStation) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('firstStation'),
          icon: BitmapDescriptor.defaultMarker,
          position: firstStation!,
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId('lastStation'),
          icon: BitmapDescriptor.defaultMarker,
          position: lastStation!,
        ),
      );
    });
  }
}