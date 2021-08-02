import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:notion_api_test/view_model/calender_view_model.dart';
import 'package:notion_api_test/view_model/create_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final nameController = TextEditingController();
  final detailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    detailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateViewModel>();
    DateTime _start = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime _end = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Todo 목록 추가'),
          actions: [
            IconButton(
                onPressed: () {
                  viewModel.upload(
                      detailController.text,
                      viewModel.selectedValue,
                      viewModel.getStatusColor(viewModel.selectedValue),
                      _start,
                      _end,
                      nameController.text);
                  Navigator.pop(context);
                  context.read<CalenderViewModel>().makeEvent();
                },
                icon: Icon(Icons.send))
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                datePickerButton(context, _start, '시작일'),
                datePickerButton(context, _end, '종료일'),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      Text('할일'),
                      SizedBox(width: 8.0),
                      Flexible(
                        child: TextField(
                          autofocus: true,
                          controller: nameController,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  child: Row(
                    children: [
                      Text('상세'),
                      SizedBox(width: 8.0),
                      Flexible(
                        child: TextField(
                          controller: detailController,
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButton(
                  value: viewModel.selectedValue,
                  items: viewModel.valueList.map((select) => DropdownMenuItem(value: select, child: Text(select))).toList(),
                  onChanged: (select) {
                    setState(() {
                      viewModel.select(select);
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }

  TextButton datePickerButton(BuildContext context, DateTime time, String text) {
    return TextButton(onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime(2030),
                  onConfirm: (date) {
                    setState(() {
                      time = date;
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.ko);
            },
                child: Text('$text: ${time.toString()}'));
  }
}
