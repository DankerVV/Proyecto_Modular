import 'package:flutter/material.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/profile_settings.dart';
import 'package:proyecto_modular/presentation/views/perfil_views/view_card.dart';

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
            //Datos de prueba
            imagePath: 'assets/profile_test.jpg', // Asegúrate de tener esta imagen en tu carpeta assets
            //ImagePath todavía no es funcional
            name: 'Orlando Loredo',
            description: 'Estudiante',
          ),
        ),
        const SizedBox(height: 40,),
        Cardinfo(context),

        const SizedBox(height: 40,),
        Settingsbutton(context),

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


Widget Cardinfo(BuildContext context){
  return(
    ElevatedButton(
       onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Cardview()),
        );
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

Widget Settingsbutton(BuildContext context){
  return(
    ElevatedButton(
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileSettings()),
        );
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
        //Esta opcion no esta disponible hasta que se cree un log in
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
