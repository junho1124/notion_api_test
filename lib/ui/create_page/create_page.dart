import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo 목록 추가'),
      ),
      // body: SafeArea(
      //   child: CalendarDatePicker(
      //     initialDate: DateTime.now(),
      //     firstDate: ,
      //   )
      // ),
    );
  }
}
