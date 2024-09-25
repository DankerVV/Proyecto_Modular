import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/add_card.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/card_pay.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/popup_menu.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/reload_physical_card_view.dart';
import 'package:proyecto_modular/presentation/views/inicio_views/preferential_card.dart'; 

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          basicButton(context),
          const SizedBox(height: 25,),
          Expanded(
            child: _buildCardsList(context), 
          ),
          addButton(context),
          const SizedBox(height: 25,),
          physicalCard(context),
          const SizedBox(height: 50,),
        ],
      ),
    );
  }

  Widget _buildCardsList(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user?.uid ?? '';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Cards')
          .where('uid', isEqualTo: uid)
          .where('activo', isEqualTo: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error al cargar las tarjetas');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final cards = snapshot.data?.docs ?? [];

        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final cardData = cards[index].data() as Map<String, dynamic>;
            return _buildCardItem(context, cardData); 
          },
        );
      },
    );
  }

  Widget _buildCardItem(BuildContext context, Map<String, dynamic> cardData) {
    Color cardColor;

    switch (cardData['tipo']) {
      case 'verde':
        cardColor = Colors.green;
        break;
      case 'amarillo':
        cardColor = Colors.yellow;
        break;
      case 'supervisor':
        cardColor = Colors.orange;
        break;
      default:
        cardColor = Colors.grey;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CardPay(cardType: cardData['tipo']),
            //PreferentialCard(cardType: cardData['tipo']),
          ),
        );
      },
      child: Card(
        color: cardColor,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tarjeta: ${cardData['tipo']}', textAlign: TextAlign.left, style: const TextStyle(fontSize: 22)),
              Text('Pasajes: ${cardData['pasajes']}', textAlign: TextAlign.left, style: const TextStyle(fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget basicButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CardPay(cardType: 'basico')),
      );
    },
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 15),
        const Text('Básico', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        const SizedBox(width: 30),
        const Expanded(child: Text(r'$9.50 mxn', textAlign: TextAlign.left, style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic))),
        buildPopupMenuButton(context),
      ],
    ),
  );
}

Widget addButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
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
        Text('Agregar Tarjeta', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 130),
        Icon(Icons.add, size: 30),
      ],
    ),
  );
}

Widget physicalCard(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
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
        Text('Recargar Tarjeta Física', textAlign: TextAlign.left, style: TextStyle(fontSize: 22)),
        SizedBox(width: 50),
        Icon(Icons.credit_card, size: 30),
      ],
    ),
  );
}
