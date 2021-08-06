import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';
import 'package:notion_api_test/util/get_status_color.dart';
import 'package:notion_api_test/repository/data_repository.dart';

class CalenderViewModel extends ChangeNotifier {
  late Map<DateTime, List<NeatCleanCalendarEvent>> _event;

  Map<DateTime, List<NeatCleanCalendarEvent>> get event => _event;

  DateTime? _selectedDate;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  DateTime? get selectedDate => _selectedDate;

  Future<void> fetch() async {
    final _userDataRepository = UserDataRepository();
    String token = await _userDataRepository.getUserToken();
    String db = await _userDataRepository.getUserDB();
    await makeEvent(token, db);
  }

  Future<void> makeEvent(String token, String db) async {
    final _calenderItems = await DataRepository().getTodoItems(token, db);
    final List<NeatCleanCalendarEvent> resultList =  _calenderItems.map((e) =>
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
      notifyListeners();
    }
    _event = groupBy(resultList, (NeatCleanCalendarEvent e) => e.startTime);
    _event.keys.map((e) => DateTime(e.year, e.month, e.day));
    _isLoaded = true;
    notifyListeners();
  }

  bool _isTabbed = true;

  bool get isTabbed => _isTabbed;

  void isTab() {
    _isTabbed = !_isTabbed;
    notifyListeners();
  }
}