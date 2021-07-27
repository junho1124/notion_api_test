import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:notion_api_test/ui/calender_page/calender_page.dart';

import '../../util/get_status_color.dart';

class MakeTodoCard extends StatelessWidget {
  const MakeTodoCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Data item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 2.0,
          color: getStatusColor(item.status),
        ),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0)
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CalenderPage(item.startDate)));
        },
        title: Text(item.name),
        subtitle: Column(
          children: [
            Text(
                '${item.status} • ${DateFormat.yMEd().format(item.startDate)}'
            ),
            Text(
                '${item.status} • ${DateFormat.yMEd().format(item.endDate)}'
            ),
          ],
        ),
        trailing: Text(item.details),
      ),
    );
  }
}

