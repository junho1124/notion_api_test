import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/repository/data_repository.dart';
import 'package:notion_api_test/repository/data_delete_repository.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final _userDataRepository = UserDataRepository();
  late Future<List<Data>> _futureTodoItems;

  Future<List<Data>> get futureTodoItems => _futureTodoItems;

  void fetch() async {
    String token = await _userDataRepository.getUserToken();
    String db = await _userDataRepository.getUserDB();

    _futureTodoItems = DataRepository().getTodoItems(token, db);
    notifyListeners();
  }

  final repository = DeleteRepository();

  void delete(String pageId) async {
    String token = await _userDataRepository.getUserToken();
    await repository.deleteTodoItem(pageId, token);
    print(pageId);
    notifyListeners();
  }
}
