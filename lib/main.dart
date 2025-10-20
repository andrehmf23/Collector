import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_collector/data/items.dart';
import 'package:flutter_application_collector/pages/all_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indice = 0;

  List<Widget> telas = [
    Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0), 
          child:TextField(
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.white),
              labelText: 'Pesquisar',
            ),
          )
        ),
        Expanded(
          child: AllPage(items: items), // agora ocupa o resto da tela
        ),
      ],
    ),
    Center(child: Text( "Minhas" )),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Collector'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: colors.onPrimary,
        foregroundColor: colors.primary,
        shape: RoundedRectangleBorder(      // formato
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: (i) => setState(() => _indice = i),
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
      body: IndexedStack(
        index: _indice,
        children: telas,
      ),
    );
  }
}