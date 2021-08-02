import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/repository/create_repository.dart';

class CreateViewModel extends ChangeNotifier {
  final List<String> _valueList = ['완료', '진행중', '시작전'];

  String _selectedValue = '완료';


  String get selectedValue => _selectedValue;

  List<String> get valueList => _valueList;

  void select(Object? value) {
    _selectedValue = value.toString();
  }

  String getStatusColor(String status) {
    switch(status) {
      case '완료':
        return 'green';
      case '진행중':
        return 'blue';
      case '시작전':
        return 'red';
      default:
        return 'transparent';
    }
  }

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