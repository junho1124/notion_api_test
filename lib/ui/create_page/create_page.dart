import 'package:flutter/material.dart';
import 'package:notion_api_test/view_model/create_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatelessWidget {
  CreatePage(this.value);
  
  final DateTime value;
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CreateViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo 목록 추가'),
        actions: [
          IconButton(
              onPressed: () {
                viewModel.upload('테스트', '완료', 'green', DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), null, '테스트완료');
              }, 
              icon: Icon(Icons.send))
        ],
      ),
      body: Container(
        child: Column(
          children: [
            DropdownButton(
                items: [
                  DropdownMenuItem(child: Text('완료')),
                  DropdownMenuItem(child: Text('시작전')),
                  DropdownMenuItem(child: Text('진행중')),
                ],

            )
          ],
        ),
      )
    );
  }
}
