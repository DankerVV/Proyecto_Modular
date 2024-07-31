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

final Set<Marker> estacionesMacrocalzada = {
  const Marker(
   markerId: MarkerId('Fray Angélico'),
   position: LatLng(20.60877646230348, -103.34264849016255),
  ),
  const Marker(
   markerId: MarkerId('Esculturas'),
   position: LatLng(20.61221878305798, -103.34289437436067),
  ),
  const Marker(
   markerId: MarkerId('Artes Plásticas'),
   position: LatLng(20.617067180515466, -103.34392085425357),
  ),
  const Marker(
   markerId: MarkerId('Clemente Orozco'),
   position: LatLng(20.621607148363523, -103.34640685773272),
  ),
  const Marker(
   markerId: MarkerId('López de Legazpi'),
   position: LatLng(20.62807833112406, -103.34862284633903),
  ),
  const Marker(
   markerId: MarkerId('Zona Industrial'),
   position: LatLng(20.633617983916732, -103.35080465572071),
  ),
  const Marker(
   markerId: MarkerId('El Dean'),
   position: LatLng(20.63822675003542, -103.35150074257507),
  ),
  const Marker(
   markerId: MarkerId('Lázaro Cárdenas'),
   position: LatLng(20.64166332951387, -103.35199628541264),
  ),
  const Marker(
   markerId: MarkerId('Héroes de Nacozari'),
   position: LatLng(20.64665019478794, -103.3527685299564),
  ),
  const Marker(
   markerId: MarkerId('Ciprés'),
   position: LatLng(20.652735209964252, -103.35343188235393),
  ),
  const Marker(
   markerId: MarkerId('Agua Azul'),
   position: LatLng(20.657835144834742, -103.35092281769549),
  ),
  const Marker(
   markerId: MarkerId('Niños Héroes'),
   position: LatLng(20.663680510563626, -103.34808674951702),
  ),
  const Marker(
   markerId: MarkerId('La Paz'),
   position: LatLng(20.666988570118125, -103.34629201364248),
  ),
  // const Marker(
  //   markerId: MarkerId('Independencia'),
  //   position: LatLng(20.671094228003696, -103.34492365116569),
  // ),
  // const Marker(
  //   markerId: MarkerId('San Juan de Dios'),
  //   position: LatLng(20.67549900826779, -103.34081079015122),
  // ),
  const Marker(
   markerId: MarkerId('Alameda'),
   position: LatLng(20.680498158996507, -103.33897223315915),
  ),
  const Marker(
   markerId: MarkerId('Juan Álvarez'),
   position: LatLng(20.68495399839043, -103.3365613046206),
  ),
  const Marker(
   markerId: MarkerId('Ciencias de la Salud'),
   position: LatLng(20.690601111123065, -103.33352194464068),
  ),
  const Marker(
   markerId: MarkerId('Circunvalación'),
   position: LatLng(20.696837190362924, -103.33013825535397),
  ),
  const Marker(
   markerId: MarkerId('Monte Olivette'),
   position: LatLng(20.7001818023283, -103.32832783331793),
  ),
  const Marker(
   markerId: MarkerId('Monumental'),
   position: LatLng(20.704654436916275, -103.32588194657757),
  ),
  const Marker(
   markerId: MarkerId('Igualdad'),
   position: LatLng(20.71177482408827, -103.32205176073239),
  ),
  const Marker(
   markerId: MarkerId('San Patricio'),
   position: LatLng(20.715886505867974, -103.31984893056884),
  ),
  const Marker(
   markerId: MarkerId('Independencia Norte'),
   position: LatLng(20.720542617780293, -103.31729662427861),
  ),
  const Marker(
   markerId: MarkerId('Zoológico'),
   position: LatLng(20.727156804641503, -103.31516928366726),
  ),
  const Marker(
   markerId: MarkerId('Huentitán'),
   position: LatLng(20.731719776862526, -103.3138094614321),
  ),
  const Marker(
   markerId: MarkerId('Mirador'),
   position: LatLng(20.737881294803707, -103.31196825304721),
  ),
};

final Set<Marker> estacionesMacroperiferico = {
  const Marker(
   markerId: MarkerId('Carretera a Chapala'),
   position: LatLng(20.592157427507374, -103.3194382488911),
  ),
  const Marker(
   markerId: MarkerId('Las Pintas'),
   position: LatLng(20.58760019121495, -103.32689277829583),
  ),
  const Marker(
   markerId: MarkerId('Artesanos'),
   position: LatLng(20.58258221413513, -103.3361597260553),
  ),
  const Marker(
   markerId: MarkerId('Adolf Horn'),
   position: LatLng(20.577187491404718, -103.36065648160492),
  ),
  const Marker(
   markerId: MarkerId('Toluquilla'),
   position: LatLng(20.579396800797102, -103.36921050080103),
  ),
  const Marker(
   markerId: MarkerId('8 de Julio'),
   position: LatLng(20.586735399340963, -103.38259679660375),
  ),
  const Marker(
   markerId: MarkerId('San Sebastianito'),
   position: LatLng(20.590713356321622, -103.3859044062935),
  ),
  // const Marker(
  //   markerId: MarkerId('Periferico Sur'),
  //   position: LatLng(20.607186986570603, -103.40106384549927),
  // ),
  const Marker(
    markerId: MarkerId('Terminal Sur de Autobuses'),
    position: LatLng(20.608523708956454, -103.40751429265997),
  ),
  const Marker(
    markerId: MarkerId('ITESO'),
    position: LatLng(20.610356939405133, -103.41509327541321),
  ),
  const Marker(
    markerId: MarkerId('López Mateos'),
    position: LatLng(20.61283080448815, -103.42376084901016),
  ),
  const Marker(
    markerId: MarkerId('Agrícola'),
    position: LatLng(20.61685397580657, -103.42906001432932),
  ),
  const Marker(
    markerId: MarkerId('El Briseño'),
    position: LatLng(20.625294041725564, -103.43360882252921),
  ),
  const Marker(
    markerId: MarkerId('Mariano Otero'),
    position: LatLng(20.632559721131738, -103.43678584164766),
  ),
  const Marker(
    markerId: MarkerId('Miramar'),
    position: LatLng(20.635986404913496, -103.43821020355942),
  ),
  const Marker(
    markerId: MarkerId('Felipe Ruvalcaba'),
    position: LatLng(20.64300613009851, -103.44115236411118),
  ),
  const Marker(
    markerId: MarkerId('El Colli'),
    position: LatLng(20.64903482194573, -103.44364778667436),
  ),
  const Marker(
    markerId: MarkerId('Chapalita Inn'),
    position: LatLng(20.65492057233334, -103.44609259978621),
  ),
  const Marker(
    markerId: MarkerId('Parque Metropolitano'),
    position: LatLng(20.661636599350665, -103.4488984738573),
  ),
  const Marker(
    markerId: MarkerId('Ciudad Granja'),
    position: LatLng(20.675116016088452, -103.4551799589128),
  ),
  const Marker(
    markerId: MarkerId('Ciudad Judicial'),
    position: LatLng(20.680743419322113, -103.45520788797698),
  ),
  const Marker(
    markerId: MarkerId('Estadio Chivas'),
    position: LatLng(20.688252842514974, -103.4553091548861),
  ),
  const Marker(
    markerId: MarkerId('Vallarta'),
    position: LatLng(20.69641572409654, -103.45456108116582),
  ),
  const Marker(
    markerId: MarkerId('San Juan de Ocotlán'),
    position: LatLng(20.706455115729963, -103.4465080167455),
  ),
  const Marker(
    markerId: MarkerId('5 de Mayo'),
    position: LatLng(20.710418088755247, -103.43951603306894),
  ),
  const Marker(
    markerId: MarkerId('Acueducto'),
    position: LatLng(20.722682985781606, -103.42116915383427),
  ),
  const Marker(
    markerId: MarkerId('Santa Margarita'),
    position: LatLng(20.73012195688269, -103.41297014823375),
  ),
  // const Marker(
  //   markerId: MarkerId('Periférico Belenes'),
  //   position: LatLng(20.738118669554297, -103.40315945386091),
  // ),
  const Marker(
   markerId: MarkerId('San Isidro'),
   position: LatLng(20.740421270051563, -103.38813493874174),
  ),
  const Marker(
   markerId: MarkerId('Centro Cultural Universitario'),
   position: LatLng(20.73932867909043, -103.38211215753417),
  ),
  const Marker(
   markerId: MarkerId('Constitución'),
   position: LatLng(20.73778499883564, -103.37642153719905),
  ),
  const Marker(
   markerId: MarkerId('Tabachines'),
   position: LatLng(20.734195021572347, -103.36304268224283),
  ),
  const Marker(
   markerId: MarkerId('La Cantera'),
   position: LatLng(20.73230425087319, -103.3560536912794),
  ),
  // const Marker(
  //   markerId: MarkerId('Periférico Norte'),
  //   position: LatLng(20.73064159072937, -103.3523478406756),
  // ),
  const Marker(
    markerId: MarkerId('El Batán'),
    position: LatLng(20.728281336332913, -103.34450368762622),
  ),
  const Marker(
    markerId: MarkerId('La Experiencia'),
    position: LatLng(20.725711481378816, -103.3375153578507),
  ),
  const Marker(
    markerId: MarkerId('Rancho Nuevo'),
    position: LatLng(20.723023945781154, -103.33029848051714),
  ),
  const Marker(
    markerId: MarkerId('Lomas del Paraíso'),
    position: LatLng(20.721495076349093, -103.32615104903562),
  ),
  // const Marker(
  //  markerId: MarkerId('Independencia Norte'),
  //  position: LatLng(20.720542617780293, -103.31729662427861),
  // ),
  const Marker(
    markerId: MarkerId('Zoológico Guadalajara'),
    position: LatLng(20.71803340321736, -103.31098321607206),
  ),
  const Marker(
    markerId: MarkerId('Barranca de Huentitán'),
    position: LatLng(20.713212228852043, -103.30101300695658),
  ),
};