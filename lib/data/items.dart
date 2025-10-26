import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './item.dart';

class Items {
  final String key;
  List<Item> items = [];

  Items({required this.key});

  /// Carrega os itens do SharedPreferences
  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getStringList(key);
    if (itemsJson != null) {
      items = itemsJson.map((i) => Item.fromJson(jsonDecode(i))).toList();
    } else {
      items = [];
    }
    print("ITEMS L -> ${items.map((i) => jsonEncode(i.toJson())).toList()}");
  }

  /// Salva os itens no SharedPreferences
  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items.map((i) => jsonEncode(i.toJson())).toList();
    print("ITEMS S -> ${itemsJson}");
    await prefs.setStringList(key, itemsJson);
  }

  /// Retorna os itens como lista de Map (JSON)
  List<Map<String, dynamic>> toJson() {
    return items.map((i) => i.toJson()).toList();
  }

  /// Adiciona um item
  Future<void> addItem(Item item) async {
    final log = items.map((i) => jsonEncode(i.toJson())).toList();
    print("ITEMS ANTES -> ${log}");
    items.add(item);
    final logi = items.map((i) => jsonEncode(i.toJson())).toList();
    print("ITEMS DEPOIS -> ${logi}");
    await saveItems();
  }

  /// Remove um item
  Future<void> removeItem(Item item) async {
    items.removeWhere((i) => i.id == item.id);
    await saveItems();
  }

  /// Atualiza um item
  Future<void> updateItem(Item item) async {
    int index = items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      items[index] = item;
      await saveItems();
    }
  }

  /// Limpa todos os itens
  Future<void> clearItems() async {
    items.clear();
    await saveItems();
  }

  /// Retorna itens filtrados por nome
  List<Item> filterByName(String search) {
    return items
        .where((item) => item.name.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  /// Retorna itens filtrados por comprado ou não
  List<Item> filterByPurchased(bool purchased) {
    return items.where((item) => item.purchased == purchased).toList();
  }
}
