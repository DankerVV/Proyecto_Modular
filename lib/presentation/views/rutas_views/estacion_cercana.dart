import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng? estacionCercana(LatLng currentPosition, List<LatLng> estaciones){
  LatLng? estacionMasCercana;
  double distanciaMinima = double.infinity;

  for (LatLng estacion in estaciones) {
    double distancia = calcularDistancia(currentPosition, estacion);
    if (distancia < distanciaMinima) {
      distanciaMinima = distancia;
      estacionMasCercana = estacion;
    }
  }
  //print('Estación más cercana: $estacionMasCercana');
  return estacionMasCercana;
}

//Fórmula de Haversine para calcular distancia
double calcularDistancia(LatLng punto1, LatLng punto2) {
  const double radioTierra = 6371.0; // Radio de la Tierra en kilómetros
  double deltaLat = _gradosARadianes(punto2.latitude - punto1.latitude);
  double deltaLng = _gradosARadianes(punto2.longitude - punto1.longitude);
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(_gradosARadianes(punto1.latitude)) * cos(_gradosARadianes(punto2.latitude)) *
      sin(deltaLng / 2) * sin(deltaLng / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return radioTierra * c;
}

double _gradosARadianes(double grados) {
  return grados * pi / 180;
}