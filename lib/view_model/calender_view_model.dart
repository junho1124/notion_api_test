import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/util/get_status_color.dart';
import 'package:notion_api_test/repository/data_repository.dart';

class CalenderViewModel extends ChangeNotifier {
  DateTime _date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<Map<DateTime, List<NeatCleanCalendarEvent>>> fetch() async {
    final _futureCalenderItems = await DataRepository().getTodoItems();
    print(_futureCalenderItems[0].pageID);
    List<NeatCleanCalendarEvent> resultList =  _futureCalenderItems.map((e) => NeatCleanCalendarEvent(e.name,
        startTime: DateTime(e.startDate.year, e.startDate.month,
            e.startDate.day, 12 , 00),
        endTime: DateTime(e.endDate.year, e.endDate.month,
            e.endDate.day, 12, 30),
        description: e.details,
        isDone: e.status == '완료' ? true : false,
        color: getStatusColor(e.status))).toList();
    for(int i = 0; i < resultList.length; i++) {
      if(resultList[i].description == 'any') {
        print(resultList[i].description);
        resultList.removeAt(i);
      }
    }
    Map<DateTime, List<NeatCleanCalendarEvent>> resultMap = {_date : resultList};
    _isLoaded = true;
    return resultMap;
  }
  void upload(String detail, String status, String color, DateTime startTime, DateTime? endTime, String name) async {
    String start = DateFormat("yyyy-MM-dd").format(startTime);
    String end;
    if(endTime != null) {
      end = DateFormat("yyyy-MM-dd").format(endTime);
    } else {
      end = "null";
    }
    print('출력은 $start');
    print('출력은 $end');
    await DataRepository().createTodoItems(detail, status, color, start, end, name);
    notifyListeners();
  }



  bool _isTabbed = true;

  bool get isTabbed => _isTabbed;

  void isTab() {
    _isTabbed = !_isTabbed;
    notifyListeners();
  }
}