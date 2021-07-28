import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/repository/create_repository.dart';

class CreateViewModel extends ChangeNotifier {
  void upload(String detail, String status, String color, DateTime startTime, DateTime? endTime, String name) async {
    String start = DateFormat("yyyy-MM-dd").format(startTime);
    String? end;
    if(endTime != null) {
      end = "${DateFormat("yyyy-MM-dd").format(endTime)}";
    } else {
      end = null;
    }
    await CreateRepository().createTodoItems(detail, status, color, start, end, name);
    notifyListeners();
  }
}