import 'package:flutter/material.dart';
import 'package:proyecto_modular/main.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/add_funds.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/view_balance.dart';

PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
  return PopupMenuButton<String>(
    icon: const Icon(Icons.more_vert, size: 30),
    onSelected: (String result) {
      switch (result) {
        case 'Agregar Fondos':
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => const AddFunds()),
          );
          break;
        case 'Ver Saldo':
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => const ViewBalance()),
          );
          break;  
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'Agregar Fondos',
        child: Text('Agregar Fondos'),
      ),
      const PopupMenuItem<String>(
        value: 'Ver Saldo',
        child: Text('Ver Saldo'),
      ),
    ],
  );
}
