import 'package:flutter/material.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/add_card.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/card_pay.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/popup_menu.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/reload_physical_card_view.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          basicButton(context),
          const SizedBox(height: 25,),
          const Spacer(),
          addButton(context),
          const SizedBox(height: 25,),
          physicalCard(context),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }
}

Widget basicButton (BuildContext context){
  return(
    ElevatedButton(
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CardPay()),
        );
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
          buildPopupMenuButton(context),

        ],
      ),
    )
  );
}

Widget addButton(BuildContext context){
  return(
    ElevatedButton(
       onPressed: (){
         Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddCard()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Agregar Tarjeta', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 130,),
          Icon(Icons.add, size: 30,)
        ],
      ),
    )
  );
}

Widget physicalCard(BuildContext context){
  return(
    ElevatedButton(
       onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ReloadPhysicalCard()),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Recargar Tarjeta Física', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 50,),
          Icon(Icons.credit_card, size: 30,)
        ],
      ),
    )
  );
}
