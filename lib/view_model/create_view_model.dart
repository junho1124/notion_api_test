import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/repository/data_create_repository.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class CreateViewModel extends ChangeNotifier {
  final List<String> _valueList = ['완료', '진행중', '시작전'];

  String _selectedValue = '완료';

  DateTime _start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  DateTime _end = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  DateTime get start => _start;

  DateTime get end => _end;

  String get selectedValue => _selectedValue;

  List<String> get valueList => _valueList;

  TextButton datePickerButton(BuildContext context, DateTime time, String text) {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
          showTitleActions: true,
          minTime: time,
          maxTime: DateTime(2030),
          onConfirm: (date) {
            return time = date;
          }, currentTime: DateTime.now(), locale: LocaleType.ko);
          notifyListeners();
    },
        child: Text('$text: ${time.toString()}}'));
  }

  void select(Object? value) {
    _selectedValue = value.toString();
    notifyListeners();
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