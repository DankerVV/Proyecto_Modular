import 'package:flutter/material.dart';

class NewCard extends StatelessWidget {
  final String cardType;
  const NewCard({super.key, required this.cardType});//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cardType),
        ) 
    );
  }
}