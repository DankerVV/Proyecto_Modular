import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//Unir las estaciones con líneas (Polylines)

final Set<Polyline> lineasLinea1 = {//Línea 1
  const Polyline(
    polylineId: PolylineId('linea1'),
    color: Colors.red,
    width: 5,
    points: [
      LatLng(20.607186986570603, -103.40106384549927), // Periferico Sur
      LatLng(20.61381622725697, -103.39570842542986),   // Mártires de Cristo Rey
      LatLng(20.62143577490687, -103.3895904632812),   // España
      LatLng(20.626795854373803, -103.38519644173627), // Patria
      LatLng(20.632877082027843, -103.3805656230677), //Isla Raza
      LatLng(20.638207926303775, -103.37698039502123), //18 de Marzo
      LatLng(20.64313978529471, -103.37277801539447), //Urdaneta
      LatLng(20.647402285135552, -103.36918890126668), //Unidad Deportiva
      LatLng(20.654274409767037, -103.36373439170744), //Santa Filomena
      LatLng(20.661032776521875, -103.35747966058331), //Washington
      LatLng(20.666799686888265, -103.35543257933723), //Mexicaltzingo
      LatLng(20.674599651060475, -103.3547623681697), //Juárez
      LatLng(20.68205802197681, -103.35410583998427), //Refugio
      LatLng(20.691807853989726, -103.35395478626097), //Mezuitán
      LatLng(20.69825754184095, -103.35500577702427), //Ávila Camacho
      LatLng(20.707986020135145, -103.35563364201886), //División del Norte
      LatLng(20.716057483192962, -103.35440940796553), //Atemajac
      LatLng(20.720817062458444, -103.35339115472385), //Dermatológico
      LatLng(20.73064159072937, -103.3523478406756), //Periférico Norte
      LatLng(20.736018912610383, -103.35049632779118), //Auditorio
    ],
  ),
};

final Set<Polyline> lineasLinea2 = {//Linea2
  const Polyline(
    polylineId: PolylineId('linea2'),
    color: Colors.blue,
    width: 5,
    points: [
      LatLng(20.674599651060475, -103.3547623681697), //Juárez
      LatLng(20.675171903719882, -103.34812394975752), // Plaza Universidad/ Guadalajara Centro
      LatLng(20.67549900826779, -103.34081079015122),  // San Juan de Dios
      LatLng(20.672761584800487, -103.33144282810905), // Belisario Domínguez
      LatLng(20.670331906945027, -103.32281329585366), // Oblatos
      LatLng(20.667546481057105, -103.31343375212585), // Cristóbal de Oñate
      LatLng(20.665308274688932, -103.30614665922452), // San Andrés
      LatLng(20.663915906067533, -103.29741508853436), // San Jacinto
      LatLng(20.662452532720074, -103.28576568805835), // La Aurora
      LatLng(20.66001511003894, -103.27603199611016),  // Tetlán
    ],
  ),
};

final Set<Polyline> lineasLinea3 = {//Linea3
  const Polyline(
    polylineId: PolylineId('linea3'),
    color: Colors.green,
    width: 5,
    points: [
      LatLng(20.741154079804534, -103.40743618393991), // Arcos de Zapopan
      LatLng(20.738118669554297, -103.40315945386091), // Periférico Belenes
      LatLng(20.72880322539078, -103.38923806177915),  // Mercado del Mar
      LatLng(20.720600577834805, -103.3870957328663),  // Zapopan Centro
      LatLng(20.71226367791625, -103.37505083932523),  // Plaza Patria
      LatLng(20.706493169501805, -103.36604988215178), // Circunvalación Country
      LatLng(20.692847525337264, -103.34836708125727), // La normal
      LatLng(20.684101045706548, -103.3479367682477),  // Santuario
      LatLng(20.675171903719882, -103.34812394975752), // Plaza Universidad/ Guadalajara Centro
      LatLng(20.671094228003696, -103.34492365116569), // Independencia
      LatLng(20.66507382422731, -103.33265599492073),  // Plaza de la Bandera
      LatLng(20.65968561686749, -103.32408386669557),  // CUCEI
      LatLng(20.650980401312346, -103.31034889450741), // Revolución
      LatLng(20.644668878623268, -103.3040080574466),  // Río Nilo
      LatLng(20.63747031817009, -103.29987459214918),  // Tlaquepaque Centro
      LatLng(20.63214122656266, -103.29619703951353),  // Lázaro Cárdenas
      LatLng(20.623155596993648, -103.28522113187933), // Central de Autobuses
    ],
  ),
};

final Set<Polyline> lineasMacrocalzada = {//Macrocalzada
  const Polyline(
    polylineId: PolylineId('macrocalzada'),
    color: Colors.orange,
    width: 5,
    points: [
      LatLng(20.60877646230348, -103.34264849016255), // Fray Angélico
      LatLng(20.61221878305798, -103.34289437436067), // Esculturas
      LatLng(20.617067180515466, -103.34392085425357), // Artes Plásticas
      LatLng(20.621607148363523, -103.34640685773272), // Clemente Orozco
      LatLng(20.62807833112406, -103.34862284633903), // López de Legazpi
      LatLng(20.633617983916732, -103.35080465572071), // Zona Industrial
      LatLng(20.63822675003542, -103.35150074257507), // El Dean
      LatLng(20.64166332951387, -103.35199628541264), // Lázaro Cárdenas
      LatLng(20.64665019478794, -103.3527685299564), // Héroes de Nacozari
      LatLng(20.652735209964252, -103.35343188235393), // Ciprés
      LatLng(20.657835144834742, -103.35092281769549), // Agua Azul
      LatLng(20.663680510563626, -103.34808674951702), // Niños Héroes
      LatLng(20.666988570118125, -103.34629201364248), // La Paz
      LatLng(20.671094228003696, -103.34492365116569), // Independencia
      LatLng(20.67549900826779, -103.34081079015122),  // San Juan de Dios
      LatLng(20.680498158996507, -103.33897223315915), // Alameda
      LatLng(20.68495399839043, -103.3365613046206), // Juan Álvarez
      LatLng(20.690601111123065, -103.33352194464068), // Ciencias de la Salud
      LatLng(20.696837190362924, -103.33013825535397), // Circunvalación
      LatLng(20.7001818023283, -103.32832783331793), // Monte Olivette
      LatLng(20.704654436916275, -103.32588194657757), // Monumental
      LatLng(20.71177482408827, -103.32205176073239), // Igualdad
      LatLng(20.715886505867974, -103.31984893056884), // San Patricio
      LatLng(20.720542617780293, -103.31729662427861), // Independencia Norte
      LatLng(20.727156804641503, -103.31516928366726), // Zoológico
      LatLng(20.731719776862526, -103.3138094614321), // Huentitán
      LatLng(20.737881294803707, -103.31196825304721), // Mirador
    ],
  ),
};

final Set<Polyline> lineasMacroperiferico = {//Macroperiferico
  const Polyline(
    polylineId: PolylineId('macroperiferico'),
    color: Colors.purple,
    width: 5,
    points: [
      LatLng(20.592157427507374, -103.3194382488911), // Carretera a Chapala
      LatLng(20.58760019121495, -103.32689277829583), // Las Pintas
      LatLng(20.58258221413513, -103.3361597260553), // Artesanos
      LatLng(20.577187491404718, -103.36065648160492), // Adolf Horn
      LatLng(20.579396800797102, -103.36921050080103), // Toluquilla
      LatLng(20.586735399340963, -103.38259679660375), // 8 de Julio
      LatLng(20.590713356321622, -103.3859044062935), // San Sebastianito
      LatLng(20.607186986570603, -103.40106384549927), // Periferico Sur
      LatLng(20.608523708956454, -103.40751429265997), // Terminal Sur de Autobuses
      LatLng(20.610356939405133, -103.41509327541321), // ITESO
      LatLng(20.61283080448815, -103.42376084901016), // López Mateos
      LatLng(20.61685397580657, -103.42906001432932), // Agrícola
      LatLng(20.625294041725564, -103.43360882252921), // El Briseño
      LatLng(20.632559721131738, -103.43678584164766), // Mariano Otero
      LatLng(20.635986404913496, -103.43821020355942), // Miramar
      LatLng(20.64300613009851, -103.44115236411118), // Felipe Ruvalcaba
      LatLng(20.64903482194573, -103.44364778667436), // El Colli
      LatLng(20.65492057233334, -103.44609259978621), // Chapalita Inn
      LatLng(20.661636599350665, -103.4488984738573), // Parque Metropolitano
      LatLng(20.675116016088452, -103.4551799589128), // Ciudad Granja
      LatLng(20.680743419322113, -103.45520788797698), // Ciudad Judicial
      LatLng(20.688252842514974, -103.4553091548861), // Estadio Chivas
      LatLng(20.69641572409654, -103.45456108116582), // Vallarta
      LatLng(20.706455115729963, -103.4465080167455), // San Juan de Ocotlán
      LatLng(20.710418088755247, -103.43951603306894), // 5 de Mayo
      LatLng(20.722682985781606, -103.42116915383427), // Acueducto
      LatLng(20.73012195688269, -103.41297014823375), // Santa Margarita
      LatLng(20.738118669554297, -103.40315945386091), // Periférico Belenes
      LatLng(20.740421270051563, -103.38813493874174), // San Isidro
      LatLng(20.73932867909043, -103.38211215753417), // Centro Cultural Universitario
      LatLng(20.73778499883564, -103.37642153719905), // Constitución
      LatLng(20.734195021572347, -103.36304268224283), // Tabachines
      LatLng(20.73230425087319, -103.3560536912794), // La Cantera
      LatLng(20.73064159072937, -103.3523478406756), //Periférico Norte
      LatLng(20.728281336332913, -103.34450368762622), // El Batán
      LatLng(20.725711481378816, -103.3375153578507), // La Experiencia
      LatLng(20.723023945781154, -103.33029848051714), // Rancho Nuevo
      LatLng(20.721495076349093, -103.32615104903562), // Lomas del Paraíso
      LatLng(20.720542617780293, -103.31729662427861), // Independencia Norte
      LatLng(20.71803340321736, -103.31098321607206), // Zoológico Guadalajara
      LatLng(20.713212228852043, -103.30101300695658), // Barranca de Huentitán
    ],
  ),
};
