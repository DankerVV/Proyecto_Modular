import 'package:flutter/material.dart';

PopupMenuButton<String> buildPopupMenuButton(BuildContext context) {
  return PopupMenuButton<String>(
    icon: const Icon(Icons.more_vert, size: 30),
    onSelected: (String result) {
      switch (result) {
        case 'Editar':
          //print('Opción 1 seleccionada');
          break;
        case 'Eliminar':
          //print('Opción 2 seleccionada');
          break;
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      const PopupMenuItem<String>(
        value: 'Editar',
        child: Text('Editar'),
      ),
      const PopupMenuItem<String>(
        value: 'Eliminar',
        child: Text('Eliminar'),
      ),
    ],
  );
}
