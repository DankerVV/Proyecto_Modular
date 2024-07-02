import 'package:flutter/material.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          basicButton()
        ],
      ),
    );
  }
}

Widget basicButton (){
  return(
    ElevatedButton(
      onPressed: (){
        //TO DO: Al presionar se activa el NFC para pagar
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 120.0),
      ),
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Expanded(child: Text('Básico', textAlign: TextAlign.left,),),
          //const Text('Básico'),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              //TO DO: Al presionar se abre el menu de opciones
            },
         ),
        ],
      ),
    )
  );
}