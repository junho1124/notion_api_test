import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/repository/data_repository.dart';
import 'package:notion_api_test/repository/data_delete_repository.dart';

class TodoViewModel extends ChangeNotifier {
  late Future<List<Data>> _futureTodoItems;

  Future<List<Data>> get futureTodoItems => _futureTodoItems;

  void fetch() {
    _futureTodoItems = DataRepository().getTodoItems();
    notifyListeners();
  }

  final repository = DeleteRepository();

  void delete(String pageId) async {
    await repository.deleteTodoItem(pageId);
    print(pageId);
    notifyListeners();
  }
}
