import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_modular/presentation/views/rutas_views/graph.dart';

// Ant Colony Optimization ACO
List<LatLng> antColony(LatLng? startPosition, LatLng? endPosition, Graph graph) {
  
  // encontrar los nodos de inicio y fin
  Node startNode = graph.nodes.firstWhere((node) => node.position == startPosition);
  Node endNode = graph.nodes.firstWhere((node) => node.position == endPosition);

  // Parámetros básicos del algoritmo
  int numAnts = 100;
  int numIterations = 50;
  double alpha = 1.0; // Importancia de las feromonas en la decision de la hormiga
  double beta = 5.0; // Importancia del costo en la decision de la hormiga
  double evaporationRate = 0.8;
  double Q = 100.0;

  // Inicializar los niveles de feromonas, es una matriz, una lista de listas
  List<List<double>> pheromoneLevels = List.generate(graph.nodes.length, (_) => List.filled(graph.nodes.length, 1.0));



  // Función para elegir el siguiente nodo al que la hormiga se moverá
  Node selectNextNode(Node currentNode, Set<Node> visited) {
    List<Edge> edges = graph.getEdgesFromNode(currentNode);// obtener las conexiones del nodo actual

    List<Edge> unvisitedEdges = edges.where((edge) => !visited.contains(edge.end)).toList();
    if(unvisitedEdges.length == 1){// si solo hay un nodo no visitado, ir hacia ese nodo sin hacer cálculos
      return unvisitedEdges[0].end;
    }

    double totalProbability = 0.0;
    List<double> probabilities = [];

    for (Edge edge in edges) {
      if (!visited.contains(edge.end)) {// comprobar si el siguiente nodo ya fue visitado
        double pheromone = pheromoneLevels[graph.nodes.indexOf(edge.start)][graph.nodes.indexOf(edge.end)];
        double heuristic = 1.0 / edge.time;
        double probability = pow(pheromone, alpha) * pow(heuristic, beta) as double;
        probabilities.add(probability);
        totalProbability += probability;
      } else {
        probabilities.add(0.0);
      }
    }

    double randomValue = Random().nextDouble() * totalProbability;
    double cumulativeProbability = 0.0;

    for (int i = 0; i < edges.length; i++) {
      cumulativeProbability += probabilities[i];
      if (randomValue <= cumulativeProbability) {
        return edges[i].end;
      }
    }

    return edges[0].end; // Por si acaso, devolver el primer nodo
  }



// funcion para actualizar los niveles de feromonas en el grafo despues de que las hormigas hayan hecho su recorrido
  void updatePheromones(List<List<Node>> allPaths, List<double> costs) {
    for (int i = 0; i < pheromoneLevels.length; i++) {
      for (int j = 0; j < pheromoneLevels[i].length; j++) {
        pheromoneLevels[i][j] *= (1 - evaporationRate);
      }
    }

    for (int k = 0; k < allPaths.length; k++) {
      double contribution = Q / costs[k];
      for (int i = 0; i < allPaths[k].length - 1; i++) {
        int startIdx = graph.nodes.indexOf(allPaths[k][i]);
        int endIdx = graph.nodes.indexOf(allPaths[k][i + 1]);
        pheromoneLevels[startIdx][endIdx] += contribution;
        pheromoneLevels[endIdx][startIdx] += contribution; // Se pone esta linea porque es un grafo bidireccional
      }
    }
  }

  List<Node> bestPath = [];
  double bestCost = double.infinity; // se pone infinity para asegurarnos de que al menos una iteracion es menos costosa



 // BUCLE PRINCIPAL DEL ALGORITMO
  for (int iteration = 0; iteration < numIterations; iteration++) {
    List<List<Node>> allPaths = [];
    List<double> costs = [];

    for (int ant = 0; ant < numAnts; ant++) { // Bucle donde cada hormiga busca su ruta
      List<Node> path = [startNode]; // path almacena la ruta de la hormiga, inicia con startNode
      Set<Node> visited = {startNode}; // visited almacena los nodos ya visitados, empezando por el startNode
      double cost = 0.0; // el costo del camino inicia en cero
      List<String> previousLines = []; // nos ayuda a detectar tranbordos para agregar un costo adicional

      while (path.last != endNode) { // bucle para construir el camino, termina cuando llega al nodo final.
        Node currentNode = path.last;
        Node nextNode = selectNextNode(currentNode, visited);

        //print('Hormiga en nodo: ${path.last.name}, Próximo nodo: ${nextNode.name}');

        // Verificar si es posible transbordar
        if (nextNode.line.contains('-')) {
          previousLines = extractLines(path.last.line); // Guarda todas las líneas de transbordo
        }
        // Verificar si se transbordó
        if (previousLines.isNotEmpty && !previousLines.contains(nextNode.line)) {
          // Si la línea del siguiente nodo no está en las líneas de transbordo, es un transbordo
          cost += 300; // Aplica un costo adicional por el transbordo
        }

        bool isDeadEnd = graph.getEdgesFromNode(currentNode).length == 1;
  
        if (visited.contains(nextNode) || isDeadEnd) {
          //print('Callejón sin salida, la hormiga ha muerto');
          break; // Termina el camino si hay un callejón sin salida
        }
        path.add(nextNode);
        visited.add(nextNode);
        cost += graph.getEdgeCost(path[path.length - 2], nextNode);
      }

      if (path.last == endNode) { // Si la hormiga llegó a su destino
        allPaths.add(path);
        costs.add(cost);
        //print('La hormiga llegó a su destino');

        if (cost < bestCost) {// actualizar la ruta con menor costo
          //print('Mejor ruta guardada');
          bestCost = cost;
          bestPath = path;
        }
      }
      
      // NOTA: si la hormiga murió en un callejón sin salida, no se agrega su ruta
    }

    updatePheromones(allPaths, costs);
  }
  bestCost = (bestCost / 60);
  print("MEJOR COSTO: $bestCost minutos");
  // convertir el mejor camino (lista de nodos) a lista de LatLng y retornarlo
  return bestPath.map((node) => node.position).toList();
}

List<String> extractLines(String line) {
  return line.split(' - '); // Divide el nombre del nodo en sus componentes de línea
}