import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewBalance extends StatefulWidget {
  const ViewBalance({super.key});

  @override
  State<ViewBalance> createState() => _ViewBalanceState();
}

class _ViewBalanceState extends State<ViewBalance> {
  double saldo = 0.0;

  @override
  void initState() {
    super.initState();
    _getSaldo();
  }

  Future<void> _getSaldo() async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      setState(() {
        saldo = userData['saldo'] ?? 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saldo'),
      ),
      body: Center(
        child: Text(
          'Saldo disponible: \$${saldo.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}