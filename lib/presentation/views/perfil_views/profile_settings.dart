import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  String _name = 'Usuario';
  String _email = 'Usuario@example.com';
  String _bio = 'Descripcion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurar perfil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Nombre'),
                readOnly: !_isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo de "Nombre" no puede estar vacio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: const InputDecoration(labelText: 'Correo Electrónico'),
                readOnly: !_isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El campo de "Correo electrónico" no puede estar vacio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                initialValue: _bio,
                decoration: const InputDecoration(labelText: 'Biografía'),
                readOnly: !_isEditing,
                maxLines: 3,
                onSaved: (value) {
                  _bio = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Perfil actualizado')),
                        );
                      }
                    }
                    _isEditing = !_isEditing;
                  });
                },
                child: Text(_isEditing ? 'Guardar Cambios' : 'Editar Perfil'),
              ),
              
              const SizedBox(height: 40,),
              Deleteaccount(context),
              
            ],
          ),
        ),
      ),
    );
  }
}

@override

//Eliminar Cuenta 
Widget Deleteaccount(context){
  return(
    ElevatedButton(
       onPressed: (){
        _showAlertDialog(context);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      ),
      child: const Row(
        children: [
          SizedBox(width: 15),
          Text('Eliminar cuenta', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 70,),
        ],
      ),
    )
  );
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Elimar cuenta'),
          content: const Text('Una vez borrada la cuenta esta no se podra recuperar. ¿Estás seguro de ello?'),
          actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cierra el diálogo
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Salir de la cuenta 
                },
                child: const Text('Aceptar'),
              ),
          ],
        );
      },
  );
}

