import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => _items;
  bool get isLoading => _isLoading;

  ItemProvider() {
    _loadItems();
  }

  void addItem(Item item) {
    if (_items.any((i) => i.id == item.id)) return;

    _items.add(item);
    _saveItems();
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    _saveItems();
    notifyListeners();
  }

  Future<void> _saveItems() async {
    if (_items.isEmpty) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('favorite_items', jsonEncode(_items));
    } catch (e) {
      print('Error saving items: $e');
    }
  }

  Future<void> _loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getString('favorite_items');

      if (data != null) {
        final List<dynamic> json = jsonDecode(data);
        _items = json.where((item) => item is Map<String, dynamic>)
            .map((e) => Item.fromJson(e))
            .toList();
      }
    } catch (e) {
      print('Error loading items: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}