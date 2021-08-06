import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/view_model/todo_view_model.dart';
import 'package:provider/provider.dart';
import '../../util/get_status_color.dart';

class MakeTodoCard extends StatefulWidget {
  const MakeTodoCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Data item;

  @override
  _MakeTodoCardState createState() => _MakeTodoCardState();
}

class _MakeTodoCardState extends State<MakeTodoCard> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TodoViewModel>();
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 2.0,
          color: getStatusColor(widget.item.status),
        ),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, offset: Offset(0, 2), blurRadius: 6.0)
        ],
      ),
      child: ListTile(
        onTap: () async {
          await showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Todo 삭제'),
                    content: Text('이 할일을 삭제 하시겠습니까?'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('취소')),
                      TextButton(
                          onPressed: () {
                            viewModel.delete(widget.item.pageID);
                            Navigator.pop(context);
                          },
                          child: Text('삭제'))
                    ],
                  );
                });
            context.read<TodoViewModel>().fetch();
        },
        title: Text(widget.item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.item.status}'),
            Text('Start • ${DateFormat.yMEd().format(widget.item.startDate)}'),
            Text('End • ${DateFormat.yMEd().format(widget.item.endDate)}'),
          ],
        ),
        trailing: Text(widget.item.details),
      ),
    );
  }
}
