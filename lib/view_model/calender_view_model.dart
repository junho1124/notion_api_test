import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:notion_api_test/util/get_status_color.dart';
import 'package:notion_api_test/repository/data_repository.dart';

class CalenderViewModel extends ChangeNotifier {

  DateTime? _selectedDate;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  DateTime? get selectedDate => _selectedDate;

  Future<Map<DateTime, List<NeatCleanCalendarEvent>>> fetch() async {
    final _futureCalenderItems = await DataRepository().getTodoItems();
    final List<NeatCleanCalendarEvent> resultList =  _futureCalenderItems.map((e) =>
      NeatCleanCalendarEvent(e.name,
          startTime: DateTime(e.startDate.year, e.startDate.month,
              e.startDate.day, e.startDate.hour, e.startDate.minute),
          endTime: DateTime(e.endDate.year, e.endDate.month,
              e.endDate.day, e.endDate.hour, e.endDate.minute),
          description: e.details,
          isDone: e.status == '완료' ? true : false,
          color: getStatusColor(e.status))).toList();
    for(int i = 0; i < resultList.length; i++) {
      if (resultList[i].description == 'any') {
        resultList.removeAt(i);
      }
    }
    final Map<DateTime, List<NeatCleanCalendarEvent>> resultMap = groupBy(resultList, (NeatCleanCalendarEvent e) => e.startTime);
    resultMap.keys.map((e) => DateTime(e.year, e.month, e.day));
    _isLoaded = true;
    return resultMap;
  }

  bool _isTabbed = true;

  bool get isTabbed => _isTabbed;

  void isTab() {
    _isTabbed = !_isTabbed;
    notifyListeners();
  }
}