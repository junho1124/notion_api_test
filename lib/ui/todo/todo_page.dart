import 'package:flutter/material.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/repository/data_repository.dart';
import 'package:notion_api_test/model/failure_model.dart';

import 'make_todo_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late Future<List<Data>> _futureTodoItems;

  @override
  void initState() {
    _futureTodoItems = DataRepository().getTodoItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureTodoItems = DataRepository().getTodoItems();
          setState(() {});
        },
        child: FutureBuilder<List<Data>>(
          future: _futureTodoItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //리스트뷰 작성
              final items = snapshot.data!;
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return (item.name != '?') ? MakeTodoCard(item: item) : Container();
                  }
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
        ),
      ),
    );
  }
}


