import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_modular/config/theme/theme_provider.dart';

final pruebaProvider = FutureProvider<List>((ref) async {
  List prueba = [];
  CollectionReference collectionReferencePrueba = FirebaseFirestore.instance.collection('prueba');

  QuerySnapshot queryPrueba = await collectionReferencePrueba.get();

  queryPrueba.docs.forEach((documento) {
    var data = documento.data() as Map<String, dynamic>;
    print(data);  // Mostrar datos en la consola
    prueba.add(data);
  });

  return prueba;
});

class SettingsView extends HookConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pruebaAsyncValue = ref.watch(pruebaProvider);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          darkMode(ref),
          const SizedBox(height: 20),
          Expanded(
            child: pruebaAsyncValue.when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(child: Text('No data found'));
                }
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].toString()),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}

Widget darkMode(WidgetRef ref) {
  final appThemeState = ref.watch(appThemeStateNotifier);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 20),
      const Text('Modo Oscuro', style: TextStyle(fontSize: 20)),
      const SizedBox(width: 10),
      Switch(
        value: appThemeState.isDarkModeEnabled,
        onChanged: (enabled) {
          if (enabled) {
            appThemeState.setDarkTheme();
          } else {
            appThemeState.setLightTheme();
          }
        },
      ),
    ],
  );
}
