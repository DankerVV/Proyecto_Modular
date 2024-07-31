import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore Database = FirebaseFirestore.instance;

Future<List> getPrueba() async{
  List prueba = [];
  CollectionReference collectionReferencePrueba = Database.collection('prueba');

  QuerySnapshot queryPrueba = await collectionReferencePrueba.get();

  queryPrueba.docs.forEach((documento){
    prueba.add(documento.data());
  });

  return prueba;

}

