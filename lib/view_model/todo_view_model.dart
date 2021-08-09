import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/model/result.dart';
import 'package:notion_api_test/repository/data_repository.dart';
import 'package:notion_api_test/repository/data_delete_repository.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';

class TodoViewModel extends ChangeNotifier {
  final _userDataRepository = UserDataRepository();
  List<Data>? _futureTodoItems;

  List<Data>? get futureTodoItems => _futureTodoItems;

  void fetch() async {
    String token = await _userDataRepository.getUserToken();
    String db = await _userDataRepository.getUserDB();
    final result = await DataRepository().getTodoItems(token, db);
    if(result is Success<List<Data>>) {
      _futureTodoItems = result.data;
    }
    notifyListeners();
  }

  final deleteRepository = DeleteRepository();

  void delete(String pageId) async {
    String token = await _userDataRepository.getUserToken();
    await deleteRepository.deleteTodoItem(pageId, token);
    print(pageId);
    notifyListeners();
  }
}
