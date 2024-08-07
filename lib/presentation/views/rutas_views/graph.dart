
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Node{
  final String name;
  final LatLng position;
  
  Node(this.name, this.position);
}

class Edge {
  final Node start;
  final Node end;
  final double time;// en segundos
  
  Edge(this.start, this.end, this.time);
}

class Graph{
  final List<Node> nodes;
  final List<Edge> edges;

  Graph(this.nodes, this.edges);

  List<Edge> getEdgesFromNode(Node node){
    return edges.where((edge) => edge.start == node || edge.end == node).toList();// grafo bidireccional
  }
}

// 107 Nodos del grafo (Todas las estaciones)
final List<Node> stations= [
  // Linea 1
  Node('Periférico Sur', const LatLng(20.607186986570603, -103.40106384549927)),// 0
  Node('Mártires de Cristo Rey', const LatLng(20.61381622725697, -103.39570842542986)),
  Node('España', const LatLng(20.62143577490687, -103.3895904632812)),
  Node('Patria', const LatLng(20.626795854373803, -103.38519644173627)),
  Node('Isla Raza', const LatLng(20.632877082027843, -103.3805656230677)),
  Node('18 de Marzo', const LatLng(20.638207926303775, -103.37698039502123)),// 5
  Node('Urdaneta', const LatLng(20.64313978529471, -103.37277801539447)),
  Node('Unidad Deportiva', const LatLng(20.647402285135552, -103.36918890126668)),
  Node('Santa Filomena', const LatLng(20.654274409767037, -103.36373439170744)),
  Node('Washington', const LatLng(20.661032776521875, -103.35747966058331)),
  Node('Mexicaltzingo', const LatLng(20.666799686888265, -103.35543257933723)),// 10
  Node('Juárez', const LatLng(20.674599651060475, -103.3547623681697)),
  Node('Refugio', const LatLng(20.68205802197681, -103.35410583998427)),
  Node('Mezquitán', const LatLng(20.691807853989726, -103.35395478626097)),
  Node('Ávila Camacho', const LatLng(20.69825754184095, -103.35500577702427)),
  Node('División del Norte', const LatLng(20.707986020135145, -103.35563364201886)),// 15
  Node('Atemajac', const LatLng(20.716057483192962, -103.35440940796553)),
  Node('Dermatológico', const LatLng(20.720817062458444, -103.35339115472385)),
  Node('Periférico Norte', const LatLng(20.73064159072937, -103.3523478406756)),
  Node('Auditorio', const LatLng(20.736018912610383, -103.35049632779118)),// 19

  // Linea 2
  // Node('Juárez', const LatLng(20.674599651060475, -103.3547623681697)),
  Node('Plaza Universidad / Guadalajara Centro', const LatLng(20.675171903719882, -103.34812394975752)),// 20
  Node('San Juan de Dios', const LatLng(20.67549900826779, -103.34081079015122)),
  Node('Belisario Domínguez', const LatLng(20.672761584800487, -103.33144282810905)),
  Node('Oblatos', const LatLng(20.670331906945027, -103.32281329585366)),
  Node('Cristóbal de Oñate', const LatLng(20.667546481057105, -103.31343375212585)),
  Node('San Andrés', const LatLng(20.665308274688932, -103.30614665922452)),// 25
  Node('San Jacinto', const LatLng(20.663915906067533, -103.29741508853436)),
  Node('La Aurora', const LatLng(20.662452532720074, -103.28576568805835)),
  Node('Tetlán', const LatLng(20.66001511003894, -103.27603199611016)),// 28

  // Linea 3
  Node('Arcos de Zapopan', const LatLng(20.741154079804534, -103.40743618393991)),// 29
  Node('Periférico Belenes', const LatLng(20.738118669554297, -103.40315945386091)),// 30
  Node('Mercado del Mar', const LatLng(20.72880322539078, -103.38923806177915)),
  Node('Zapopan Centro', const LatLng(20.720600577834805, -103.3870957328663)),
  Node('Plaza Patria', const LatLng(20.71226367791625, -103.37505083932523)),
  Node('Circunvalación Country', const LatLng(20.706493169501805, -103.36604988215178)),
  // Node('Ávila Camacho', const LatLng(20.69825754184095, -103.35500577702427)),
  Node('La normal', const LatLng(20.692847525337264, -103.34836708125727)),// 35
  Node('Santuario', const LatLng(20.684101045706548, -103.3479367682477)),
  // Node('Plaza Universidad / Guadalajara Centro', const LatLng(20.675171903719882, -103.34812394975752)),
  Node('Independencia', const LatLng(20.671094228003696, -103.34492365116569)),
  Node('Plaza de la Bandera', const LatLng(20.66507382422731, -103.33265599492073)),
  Node('CUCEI', const LatLng(20.65968561686749, -103.32408386669557)),
  Node('Revolución', const LatLng(20.650980401312346, -103.31034889450741)),// 40
  Node('Río Nilo', const LatLng(20.644668878623268, -103.3040080574466)),
  Node('Tlaquepaque Centro', const LatLng(20.63747031817009, -103.29987459214918)),
  Node('Lázaro Cárdenas', const LatLng(20.63214122656266, -103.29619703951353)),
  Node('Central de Autobuses', const LatLng(20.623155596993648, -103.28522113187933)),// 44

  // Macro Calzada
  Node('Fray Angélico', const LatLng(20.60877646230348, -103.34264849016255)),// 45
  Node('Esculturas', const LatLng(20.61221878305798, -103.34289437436067)),
  Node('Artes Plásticas', const LatLng(20.617067180515466, -103.34392085425357)),
  Node('Clemente Orozco', const LatLng(20.621607148363523, -103.34640685773272)),
  Node('López de Legazpi', const LatLng(20.62807833112406, -103.34862284633903)),
  Node('Zona Industrial', const LatLng(20.633617983916732, -103.35080465572071)),// 50
  Node('El Dean', const LatLng(20.63822675003542, -103.35150074257507)),
  Node('Lázaro Cárdenas', const LatLng(20.64166332951387, -103.3519962854126)),
  Node('Héroes de Nacozari', const LatLng(20.64665019478794, -103.3527685299564)),
  Node('Ciprés', const LatLng(20.652735209964252, -103.35343188235393)),
  Node('Agua Azul', const LatLng(20.657835144834742, -103.35092281769549)),// 55
  Node('Niños Héroes', const LatLng(20.663680510563626, -103.34808674951702)),
  Node('La Paz', const LatLng(20.666988570118125, -103.34629201364248)),
  // Node('Independencia', const LatLng(20.671094228003696, -103.34492365116569)),
  // Node('San Juan de Dios', const LatLng(20.67549900826779, -103.34081079015122)),
  Node('Alameda', const LatLng(20.680498158996507, -103.33897223315915)),
  Node('Juan Álvarez', const LatLng(20.68495399839043, -103.3365613046206)),
  Node('Ciencias de la Salud', const LatLng(20.690601111123065, -103.33352194464068)),// 60
  Node('Circunvalación', const LatLng(20.696837190362924, -103.33013825535397)),
  Node('Monte Olivette', const LatLng(20.7001818023283, -103.32832783331793)),
  Node('Monumental', const LatLng(20.704654436916275, -103.32588194657757)),
  Node('Igualdad', const LatLng(20.71177482408827, -103.32205176073239)),
  Node('San Patricio', const LatLng(20.715886505867974, -103.31984893056884)),// 65
  Node('Independencia Norte', const LatLng(20.720542617780293, -103.31729662427861)),
  Node('Zoológico', const LatLng(20.727156804641503, -103.31516928366726)),
  Node('Huentitán', const LatLng(20.731719776862526, -103.3138094614321)),
  Node('Mirador', const LatLng(20.737881294803707, -103.31196825304721)),// 69

  // Macro Periferico
  Node('Carretera a Chapala', const LatLng(20.592157427507374, -103.3194382488911)),// 70
  Node('Las Pintas', const LatLng(20.58760019121495, -103.32689277829583)),
  Node('Artesanos', const LatLng(20.58258221413513, -103.3361597260553)),
  Node('Adolf Horn', const LatLng(20.577187491404718, -103.36065648160492)),
  Node('Toluquilla', const LatLng(20.579396800797102, -103.36921050080103)),
  Node('8 de Julio', const LatLng(20.586735399340963, -103.38259679660375)),// 75
  Node('San Sebastianito', const LatLng(20.590713356321622, -103.3859044062935)),
  // Node('Periférico Sur', const LatLng(20.607186986570603, -103.40106384549927)),
  Node('Terminal Sur de Autobuses', const LatLng(20.608523708956454, -103.40751429265997)),
  Node('ITESO', const LatLng(20.610356939405133, -103.41509327541321)),
  Node('López Mateos', const LatLng(20.61283080448815, -103.42376084901016)),
  Node('Agrícola', const LatLng(20.61685397580657, -103.42906001432932)),// 80
  Node('El Briseño', const LatLng(20.625294041725564, -103.43360882252921)),
  Node('Mariano Otero', const LatLng(20.632559721131738, -103.43678584164766)),
  Node('Miramar', const LatLng(20.635986404913496, -103.43821020355942)),
  Node('Felipe Ruvalcaba', const LatLng(20.64300613009851, -103.44115236411118)),
  Node('El Colli', const LatLng(20.64903482194573, -103.44364778667436)),// 85
  Node('Chapalita Inn', const LatLng(20.65492057233334, -103.44609259978621)),
  Node('Parque Metropolitano', const LatLng(20.661636599350665, -103.4488984738573)),
  Node('Ciudad Granja', const LatLng(20.675116016088452, -103.4551799589128)),
  Node('Ciudad Judicial', const LatLng(20.680743419322113, -103.45520788797698)),
  Node('Estadio Chivas', const LatLng(20.688252842514974, -103.4553091548861)),// 90
  Node('Vallarta', const LatLng(20.69641572409654, -103.45456108116582)),
  Node('San Juan de Ocotlán', const LatLng(20.706455115729963, -103.4465080167455)),
  Node('5 de Mayo', const LatLng(20.710418088755247, -103.43951603306894)),
  Node('Acueducto', const LatLng(20.722682985781606, -103.42116915383427)),
  Node('Santa Margarita', const LatLng(20.73012195688269, -103.41297014823375)),// 95
  // Node('Periférico Belenes', const LatLng(20.738118669554297, -103.40315945386091)),
  Node('San Isidro', const LatLng(20.740421270051563, -103.38813493874174)),
  Node('Centro Cultural Universitario', const LatLng(20.73932867909043, -103.38211215753417)),
  Node('Constitución', const LatLng(20.73778499883564, -103.37642153719905)),
  Node('Tabachines', const LatLng(20.734195021572347, -103.36304268224283)),
  Node('La Cantera', const LatLng(20.73230425087319, -103.3560536912794)),// 100
  // Node('Periférico Norte', const LatLng(20.73064159072937, -103.3523478406756)),
  Node('El Batán', const LatLng(20.728281336332913, -103.34450368762622)),
  Node('La Experiencia', const LatLng(20.725711481378816, -103.3375153578507)),
  Node('Rancho Nuevo', const LatLng(20.723023945781154, -103.33029848051714)),
  Node('Lomas del Paraíso', const LatLng(20.721495076349093, -103.32615104903562)),
  // Node('Independencia Norte', const LatLng(20.720542617780293, -103.31729662427861)),
  Node('Zoológico Guadalajara', const LatLng(20.71803340321736, -103.31098321607206)),// 105
  Node('Barranca de Huentitán', const LatLng(20.713212228852043, -103.30101300695658)),// 106
];

// Promedio de tiempo entre estaciones de cada linea, en segundos
double tiempoL1 = 189;// 63 min entre 20 estaciones
double tiempoL2 = 216;// 36 min entre 10 estaciones
double tiempoL3 = 250;// 75 min entre 18 estaciones
double tiempoMc = 102;// 46 min entre 27 estaciones
double tiempoMp = 128;// 90 min entre 42 estaciones

// Vamos a conectar los nodos
final List<Edge> connections = [
  // Linea 1
  Edge(stations[0], stations[1], tiempoL1),
  Edge(stations[1], stations[2], tiempoL1),
  Edge(stations[2], stations[3], tiempoL1),
  Edge(stations[3], stations[4], tiempoL1),
  Edge(stations[4], stations[5], tiempoL1),
  Edge(stations[5], stations[6], tiempoL1),
  Edge(stations[6], stations[7], tiempoL1),
  Edge(stations[7], stations[8], tiempoL1),
  Edge(stations[8], stations[9], tiempoL1),
  Edge(stations[9], stations[10], tiempoL1),
  Edge(stations[10], stations[11],tiempoL1),
  Edge(stations[11], stations[12],tiempoL1),
  Edge(stations[12], stations[13],tiempoL1),
  Edge(stations[13], stations[14],tiempoL1),
  Edge(stations[14], stations[15],tiempoL1),
  Edge(stations[15], stations[16],tiempoL1),
  Edge(stations[16], stations[17],tiempoL1),
  Edge(stations[17], stations[18],tiempoL1),
  Edge(stations[18], stations[19],tiempoL1),
  
  // Linea 2
  Edge(stations[11], stations[20],tiempoL2),
  Edge(stations[20], stations[21],tiempoL2),
  Edge(stations[21], stations[22],tiempoL2),
  Edge(stations[22], stations[23],tiempoL2),
  Edge(stations[23], stations[24],tiempoL2),
  Edge(stations[24], stations[25],tiempoL2),
  Edge(stations[25], stations[26],tiempoL2),
  Edge(stations[26], stations[27],tiempoL2),
  Edge(stations[27], stations[28],tiempoL2),

  // Linea 3
  Edge(stations[29], stations[30],tiempoL3),
  Edge(stations[30], stations[31],tiempoL3),
  Edge(stations[31], stations[32],tiempoL3),
  Edge(stations[32], stations[33],tiempoL3),
  Edge(stations[33], stations[34],tiempoL3),
  Edge(stations[34], stations[14],tiempoL3),
  Edge(stations[14], stations[35],tiempoL3),
  Edge(stations[35], stations[36],tiempoL3),
  Edge(stations[36], stations[20],tiempoL3),
  Edge(stations[20], stations[37],tiempoL3),
  Edge(stations[37], stations[38],tiempoL3),
  Edge(stations[38], stations[39],tiempoL3),
  Edge(stations[39], stations[40],tiempoL3),
  Edge(stations[40], stations[41],tiempoL3),
  Edge(stations[41], stations[42],tiempoL3),
  Edge(stations[42], stations[43],tiempoL3),
  Edge(stations[43], stations[44],tiempoL3),

  // Macro Calzada
  Edge(stations[45], stations[46],tiempoMc),
  Edge(stations[46], stations[47],tiempoMc),
  Edge(stations[47], stations[48],tiempoMc),
  Edge(stations[48], stations[49],tiempoMc),
  Edge(stations[49], stations[50],tiempoMc),
  Edge(stations[50], stations[51],tiempoMc),
  Edge(stations[51], stations[52],tiempoMc),
  Edge(stations[52], stations[53],tiempoMc),
  Edge(stations[53], stations[54],tiempoMc),
  Edge(stations[54], stations[55],tiempoMc),
  Edge(stations[55], stations[56],tiempoMc),
  Edge(stations[56], stations[57],tiempoMc),
  Edge(stations[57], stations[37],tiempoMc),
  Edge(stations[37], stations[21],tiempoMc),
  Edge(stations[21], stations[58],tiempoMc),
  Edge(stations[58], stations[59],tiempoMc),
  Edge(stations[59], stations[60],tiempoMc),
  Edge(stations[60], stations[61],tiempoMc),
  Edge(stations[61], stations[62],tiempoMc),
  Edge(stations[62], stations[63],tiempoMc),
  Edge(stations[63], stations[64],tiempoMc),
  Edge(stations[64], stations[65],tiempoMc),
  Edge(stations[65], stations[66],tiempoMc),
  Edge(stations[66], stations[67],tiempoMc),
  Edge(stations[67], stations[68],tiempoMc),
  Edge(stations[68], stations[69],tiempoMc),

  // Macro Periférico
  Edge(stations[70], stations[71],tiempoMp),
  Edge(stations[71], stations[72],tiempoMp),
  Edge(stations[72], stations[73],tiempoMp),
  Edge(stations[73], stations[74],tiempoMp),
  Edge(stations[74], stations[75],tiempoMp),
  Edge(stations[75], stations[76],tiempoMp),
  Edge(stations[76], stations[0],tiempoMp),
  Edge(stations[0], stations[77],tiempoMp),
  Edge(stations[77], stations[78],tiempoMp),
  Edge(stations[78], stations[79],tiempoMp),
  Edge(stations[79], stations[80],tiempoMp),
  Edge(stations[80], stations[81],tiempoMp),
  Edge(stations[81], stations[82],tiempoMp),
  Edge(stations[82], stations[83],tiempoMp),
  Edge(stations[83], stations[84],tiempoMp),
  Edge(stations[84], stations[85],tiempoMp),
  Edge(stations[85], stations[86],tiempoMp),
  Edge(stations[86], stations[87],tiempoMp),
  Edge(stations[87], stations[88],tiempoMp),
  Edge(stations[88], stations[89],tiempoMp),
  Edge(stations[89], stations[90],tiempoMp),
  Edge(stations[90], stations[91],tiempoMp),
  Edge(stations[91], stations[92],tiempoMp),
  Edge(stations[92], stations[93],tiempoMp),
  Edge(stations[93], stations[94],tiempoMp),
  Edge(stations[94], stations[95],tiempoMp),
  Edge(stations[95], stations[30],tiempoMp),
  Edge(stations[30], stations[96],tiempoMp),
  Edge(stations[96], stations[97],tiempoMp),
  Edge(stations[97], stations[98],tiempoMp),
  Edge(stations[98], stations[99],tiempoMp),
  Edge(stations[99], stations[100],tiempoMp),
  Edge(stations[100], stations[18],tiempoMp),
  Edge(stations[18], stations[101],tiempoMp),
  Edge(stations[101], stations[102],tiempoMp),
  Edge(stations[102], stations[103],tiempoMp),
  Edge(stations[103], stations[104],tiempoMp),
  Edge(stations[104], stations[66],tiempoMp),
  Edge(stations[66], stations[105],tiempoMp),
  Edge(stations[105], stations[106],tiempoMp),
];

final Graph transportGraph = Graph(stations, connections);
