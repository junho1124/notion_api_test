import 'package:flutter/material.dart';
import 'package:notion_api_test/view_model/todo_view_model.dart';
import 'package:provider/provider.dart';
import 'make_todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    context.read<TodoViewModel>().fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodoViewModel>();
    final items = viewModel.futureTodoItems ?? [];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Todo'),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              viewModel.fetch();
              setState(() {});
            },
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];
                  return (item.name != '?')
                      ? MakeTodoCard(item: item)
                      : Container();
                })));
  }
}
