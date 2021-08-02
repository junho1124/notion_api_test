import 'package:flutter/material.dart';
import 'package:notion_api_test/view_model/create_view_model.dart';
import 'package:provider/provider.dart';

class CreatePage extends StatefulWidget {
  CreatePage(this.start, this.end);

  final DateTime start;
  final DateTime end;

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
                      widget.start,
                      widget.end,
                      nameController.text);
                  Navigator.pop(context);
                },
                icon: Icon(Icons.send))
          ],
        ),
        body: Container(
          child: Column(
            children: [
              TextField(
                autofocus: true,
                controller: nameController,
              ),
              TextField(
                controller: detailController,
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
        ));
  }
}
