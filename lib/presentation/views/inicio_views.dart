import 'package:flutter/material.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          basicButton(),
          const SizedBox(height: 25,),
          addButton(),
          const SizedBox(height: 25,),
          const Spacer(),
          physicalCard(),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}

Widget basicButton (){
  return(
    ElevatedButton(
      onPressed: (){
        //TO DO: Al presionar se activa el NFC para pagar, hacerlo en otro archivo
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye espacio equitativamente
        children: [
          const SizedBox(width: 15),
          const Text('Básico', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          const SizedBox(width: 30),
          const Expanded(child: Text(r'$9.50 mxn', textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),)),
          IconButton(
            icon: const Icon(Icons.more_vert, size: 30,),
            onPressed: () {
              //TO DO: Al presionar se abre el menu de opciones, hacerlo en otro archivo
            },
         ),
        ],
      ),
    )
  );
}

Widget addButton(){
  return(
    ElevatedButton(
       onPressed: (){
        //TO DO: Al presionar se abre un menú para registrar un nuevo pasaje, hacerlo en otro archivo
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Agregar Tarjeta   ', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          Icon(Icons.add, size: 30,)
        ],
      ),
    )
  );
}

Widget physicalCard(){
  return(
    ElevatedButton(
       onPressed: (){
        //TO DO: Al presionar se activa el NFC para encontrar y modificar una tarjeta física, hacerlo en otro archivo
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Recargar Tarjeta Física   ', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          Icon(Icons.credit_card, size: 30,)
        ],
      ),
    )
  );
}