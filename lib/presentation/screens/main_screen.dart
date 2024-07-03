import 'package:flutter/material.dart';
import 'package:proyecto_modular/presentation/views/inicio_views.dart';
import 'package:proyecto_modular/presentation/views/perfil_view.dart';
import 'package:proyecto_modular/presentation/views/rutas_view.dart';
import 'package:proyecto_modular/presentation/views/settings_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screens = [
      const InicioView(),
      const PerfilView(),
      const RutasView(),
      const SettingsView(),
    ];
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.house, size: 30,),
            activeIcon: const Icon(Icons.house, size: 40,),
            label: 'Inicio', 
            backgroundColor: colors.primary,
            ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.person, size: 30,),
            activeIcon: const Icon(Icons.person, size: 40,),
            label: 'Perfil',
            backgroundColor: colors.primary,
            ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.train, size: 30,),
            activeIcon: const Icon(Icons.train, size: 40,),
            label: 'Rutas',
            backgroundColor: colors.primary,
            ),

          BottomNavigationBarItem(
            icon: const Icon(Icons.settings, size: 30,),
            activeIcon: const Icon(Icons.settings, size: 40,),
            label: 'Configuración',
            backgroundColor: colors.primary,
            ),
            
        ],
        selectedFontSize: 18,
        ),
    );
  }
}