import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estacion_cercana.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_coordenadas.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/estaciones_polylines.dart';

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
  bool isPlanningRoute = false; // Bandera para controlar el modo de planificación de ruta

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
                //   ...estacionesLinea1,
                //   ...estacionesLinea2,
                //   ...estacionesLinea3,
                //   ...estacionesMacrocalzada,
                //   ...estacionesMacroperiferico
              },
              polylines: {
                ...lineasLinea1,
                ...lineasLinea2,
                ...lineasLinea3,
                ...lineasMacrocalzada,
                ...lineasMacroperiferico
              },
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
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Toque en el mapa su destino')),
              );
              print('Posición Actual: $currentPosition');
              LatLng? firstStation = estacionCercana(currentPosition!, estaciones);
            },
            child: const Text('Planear una ruta', style: TextStyle(fontSize: 18),),
          ),
        ),
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
      //print('POSICION ACTUAL: $currentPosition');
    });
  }

  void _handleTap(LatLng tappedPoint) {
    setState(() {
      finalPosition = tappedPoint;
      isPlanningRoute = false; // Desactivar bandera después de seleccionar el destino
    });
    print('Destino seleccionado: $finalPosition');
    LatLng? LastStation = estacionCercana(finalPosition!, estaciones);
  }

}