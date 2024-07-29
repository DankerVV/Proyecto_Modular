import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Marker> estacionesLinea1 = {
  const Marker(
    markerId: MarkerId('Periferico Sur'),
    position: LatLng(20.607186986570603, -103.40106384549927),
  ),
  const Marker(
    markerId: MarkerId('Mártires de Cristo Rey'),
    position: LatLng(20.61381622725697, -103.39570842542986),
  ),
  const Marker(
    markerId: MarkerId('España'),
    position: LatLng(20.62143577490687, -103.3895904632812),
  ),
  const Marker(
    markerId: MarkerId('Patria'),
    position: LatLng(20.626795854373803, -103.38519644173627),
  ),
  const Marker(
    markerId: MarkerId('Isla Raza'),
    position: LatLng(20.632877082027843, -103.3805656230677),
  ),
  const Marker(
    markerId: MarkerId('18 de Marzo'),
    position: LatLng(20.638207926303775, -103.37698039502123),
  ),
  const Marker(
    markerId: MarkerId('Urdaneta'),
    position: LatLng(20.64313978529471, -103.37277801539447),
  ),
  const Marker(
    markerId: MarkerId('Unidad Deportiva'),
    position: LatLng(20.647402285135552, -103.36918890126668),
  ),
  const Marker(
    markerId: MarkerId('Santa Filomena'),
    position: LatLng(20.654274409767037, -103.36373439170744),
  ),
  const Marker(
    markerId: MarkerId('Washington'),
    position: LatLng(20.661032776521875, -103.35747966058331),
  ),
  const Marker(
    markerId: MarkerId('Mexicaltzingo'),
    position: LatLng(20.666799686888265, -103.35543257933723),
  ),
  const Marker(
    markerId: MarkerId('Juárez'),
    position: LatLng(20.674599651060475, -103.3547623681697),
  ),
  const Marker(
    markerId: MarkerId('Refugio'),
    position: LatLng(20.68205802197681, -103.35410583998427),
  ),
  const Marker(
    markerId: MarkerId('Mezquitán'),
    position: LatLng(20.691807853989726, -103.35395478626097),
  ),
  const Marker(
    markerId: MarkerId('Ávila Camacho'),
    position: LatLng(20.69825754184095, -103.35500577702427),
  ),
  const Marker(
    markerId: MarkerId('División del Norte'),
    position: LatLng(20.707986020135145, -103.35563364201886),
  ),
  const Marker(
    markerId: MarkerId('Atemajac'),
    position: LatLng(20.716057483192962, -103.35440940796553),
  ),
  const Marker(
    markerId: MarkerId('Dermatológico'),
    position: LatLng(20.720817062458444, -103.35339115472385),
  ),
  const Marker(
    markerId: MarkerId('Periférico Norte'),
    position: LatLng(20.73064159072937, -103.3523478406756),
  ),
  const Marker(
    markerId: MarkerId('Auditorio'),
    position: LatLng(20.736018912610383, -103.35049632779118),
  ),
};

final Set<Marker> estacionesLinea2 = {
  // const Marker(
  //  markerId: MarkerId('Juárez'),
  //  position: LatLng(20.674599651060475, -103.3547623681697),
  // ),
  const Marker(
    markerId: MarkerId('Plaza Universidad/ Guadalajara Centro'),
    position: LatLng(20.675171903719882, -103.34812394975752),
  ),
  const Marker(
    markerId: MarkerId('San Juan de Dios'),
    position: LatLng(20.67549900826779, -103.34081079015122),
  ),
  const Marker(
    markerId: MarkerId('Belisario Domínguez'),
    position: LatLng(20.672761584800487, -103.33144282810905),
  ),
  const Marker(
    markerId: MarkerId('Oblatos'),
    position: LatLng(20.670331906945027, -103.32281329585366),
  ),
  const Marker(
    markerId: MarkerId('Cristóbal de Oñate'),
    position: LatLng(20.667546481057105, -103.31343375212585),
  ),
  const Marker(
    markerId: MarkerId('San Andrés'),
    position: LatLng(20.665308274688932, -103.30614665922452),
  ),
  const Marker(
    markerId: MarkerId('San Jacinto'),
    position: LatLng(20.663915906067533, -103.29741508853436),
  ),
  const Marker(
    markerId: MarkerId('La Aurora'),
    position: LatLng(20.662452532720074, -103.28576568805835),
  ),
  const Marker(
    markerId: MarkerId('Tetlán'),
    position: LatLng(20.66001511003894, -103.27603199611016),
  ),
};

final Set<Marker> estacionesLinea3 = {
  const Marker(
   markerId: MarkerId('Arcos de Zapopan'),
   position: LatLng(20.741154079804534, -103.40743618393991),
  ),
  const Marker(
   markerId: MarkerId('Periférico Belenes'),
   position: LatLng(20.738118669554297, -103.40315945386091),
  ),
  const Marker(
   markerId: MarkerId('Mercado del Mar'),
   position: LatLng(20.72880322539078, -103.38923806177915),
  ),
  const Marker(
   markerId: MarkerId('Zapopan Centro'),
   position: LatLng(20.720600577834805, -103.3870957328663),
  ),
  const Marker(
   markerId: MarkerId('Plaza Patria'),
   position: LatLng(20.71226367791625, -103.37505083932523),
  ),
  const Marker(
   markerId: MarkerId('Circunvalación Country'),
   position: LatLng(20.706493169501805, -103.36604988215178),
  ),
  // const Marker(
  //  markerId: MarkerId('Ávila Camacho'),
  //  position: LatLng(20.699318250095434, -103.35488004016892),
  // ),
  const Marker(
   markerId: MarkerId('La normal'),
   position: LatLng(20.692847525337264, -103.34836708125727),
  ),
  const Marker(
   markerId: MarkerId('Santuario'),
   position: LatLng(20.684101045706548, -103.3479367682477),
  ),
  // const Marker(
  //   markerId: MarkerId('Plaza Universidad/ Guadalajara Centro'),
  //   position: LatLng(20.675171903719882, -103.34812394975752),
  // ),
  const Marker(
    markerId: MarkerId('Independencia'),
    position: LatLng(20.671094228003696, -103.34492365116569),
  ),
  const Marker(
    markerId: MarkerId('Plaza de la Bandera'),
    position: LatLng(20.66507382422731, -103.33265599492073),
  ),
  const Marker(
    markerId: MarkerId('CUCEI'),
    position: LatLng(20.65968561686749, -103.32408386669557),
  ),
  const Marker(
    markerId: MarkerId('Revolución'),
    position: LatLng(20.650980401312346, -103.31034889450741),
  ),
  const Marker(
    markerId: MarkerId('Río Nilo'),
    position: LatLng(20.644668878623268, -103.3040080574466),
  ),
  const Marker(
    markerId: MarkerId('Tlaquepaque Centro'),
    position: LatLng(20.63747031817009, -103.29987459214918),
  ),
  const Marker(
    markerId: MarkerId('Lázaro Cárdenas'),
    position: LatLng(20.63214122656266, -103.29619703951353),
  ),
  const Marker(
    markerId: MarkerId('Central de Autobuses'),
    position: LatLng(20.623155596993648, -103.28522113187933),
  ),
};