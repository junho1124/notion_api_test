import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart'
    as Cal;
import 'package:flutter_neat_and_clean_calendar/neat_and_clean_calendar_event.dart';
import 'package:notion_api_test/model/failure_model.dart';
import 'package:notion_api_test/ui/create_page/create_page.dart';
import 'package:notion_api_test/ui/todo/todo_page.dart';
import 'package:notion_api_test/view_model/calender_view_model.dart';
import 'package:provider/provider.dart';

class CalenderPage extends StatefulWidget {
  CalenderPage(this.startDate);

  final DateTime startDate;

  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {


  @override
  void initState() {
    super.initState();
    final viewModel = context.read<CalenderViewModel>();
    viewModel.fetch();
    viewModel.makeEvent().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CalenderViewModel>();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          viewModel.fetch();
          setState(() {});
        },
        child: SafeArea(
            child: !viewModel.isLoaded
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : FutureBuilder<Map<DateTime, List<NeatCleanCalendarEvent>>>(
                    future: context.watch<CalenderViewModel>().makeEvent(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Cal.Calendar(
                          startOnMonday: true,
                          initialDate: widget.startDate,
                          weekDays: ['월', '화', '수', '목', '금', '토', '일'],
                          events: snapshot.data,
                          isExpandable: true,
                          eventDoneColor: Colors.green,
                          selectedColor: Colors.pink,
                          todayColor: Colors.blue,
                          eventColor: Colors.grey,
                          locale: 'de_DE',
                          todayButtonText: 'Today',
                          isExpanded: true,
                          expandableDateFormat: 'yyyy년 MM월 dd일',
                          dayOfWeekStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 11),
                          onEventSelected: (e) {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TodoPage()));
                          },
                        );
                      } else if (snapshot.hasError) {
                        //에러 메세지 발생
                        final failure = snapshot.error as Failure;
                        return Center(
                          child: Text(failure.message),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => CreatePage())).whenComplete(() => viewModel.fetch());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
