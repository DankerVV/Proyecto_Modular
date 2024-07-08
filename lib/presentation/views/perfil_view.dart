import 'package:flutter/material.dart';

class PerfilView extends StatelessWidget {
  const PerfilView({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Center(
          child: ProfileCard(
            imagePath: 'assets/user.jpg', // Asegúrate de tener esta imagen en tu carpeta assets
            name: 'Usuario genérico',
            description: 'Estudiante',
          ),
        ),
        const SizedBox(height: 40,),
        Cardinfo(),

        const SizedBox(height: 40,),
        Settingsbutton(),

        const SizedBox(height: 40,),
        Logoutbutton(),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String description;

  ProfileCard({
    required this.imagePath,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius:60,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


Widget Cardinfo(){
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
          Text('Ver tarjetas', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 130,),
          Icon(Icons.credit_card, size: 30,)
        ],
      ),
    )
  );
}

Widget Settingsbutton(){
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
          Text('Configurar Perfil', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 130,),
          Icon(Icons.settings, size: 30,)
        ],
      ),
    )
  );
}

 
Widget Logoutbutton(){
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
          Text('Cerrar sesión', textAlign: TextAlign.left, style: TextStyle(fontSize: 22),),
          SizedBox(width: 130,),
          Icon(Icons.logout, size: 30,)
        ],
      ),
    )
  );
}
