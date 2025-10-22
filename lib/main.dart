import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_collector/pages/item_page.dart';
import 'package:flutter_application_collector/pages/items_page.dart';
import 'package:flutter_application_collector/pages/register_page.dart';

void main() async {
  runApp(const MyApp());
}

//____________________[MyApp]____________________//
// Definição dos temas utilizados em toda a aplicação

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collector',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.white,       // cor principal
          onPrimary: Colors.black,     // texto ou ícone sobre primary
          surface: Colors.white,       // cor de cards, botões, etc.
          onSurface: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          onPrimary: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
      ),
      home: const HomePage(),
    );
  }
}

//____________________[HomePage]____________________//

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.book),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage()
            )
          );
        },
        child: Icon(Icons.add),
        backgroundColor: colors.onPrimary,
        foregroundColor: colors.primary,
        shape: RoundedRectangleBorder(      // formato
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _filter,
        onTap: (i) => setState(() => _filter = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Todas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Desejadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Minhas',
          ),
        ],
      ),
      backgroundColor: colors.surface,
      body: ItemsPage(filter: _filter)
    );
  }
}