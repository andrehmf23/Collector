import 'package:flutter/material.dart';
import 'package:flutter_application_collector/pages/items_page.dart';
import 'package:flutter_application_collector/pages/register_page.dart';
import 'package:flutter_application_collector/data/items.dart';


void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container(); // substitui o amarelo por um container vazio
  };
  
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

//____________________[MyApp]____________________//
// Definição dos temas utilizados em toda a aplicação

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Collector',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.blueGrey,
          onSecondary: Colors.cyan,
          tertiary: Color.fromARGB(255, 199, 199, 199),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.cyan,
          tertiary: Color.fromARGB(255, 22, 22, 22),
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
  Items items = Items(key: 'items');

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    await items.loadItems(); // espera carregar do SharedPreferences
    setState(() {}); // atualiza a UI
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Collector',
          style: TextStyle(
            color: colors.onPrimary,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RegisterPage(items: items),
            )
          );
          setState(() {});
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
        backgroundColor: colors.primary,        // cor de fundo do BottomNavigationBar
        selectedItemColor: colors.onSecondary,    // cor do ícone/texto selecionado
        unselectedItemColor: colors.secondary,  // cor dos ícones/textos não selecionados
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list,
            ),
            label: 'Todas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Desejadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Minhas',
          ),
        ],
      ),
      body: ItemsPage(filter: _filter, items: items),
    );
  }
}