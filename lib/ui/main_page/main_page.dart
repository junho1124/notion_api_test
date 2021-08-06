import 'package:notion_api_test/ui/calender_page/calender_page.dart';
import 'package:notion_api_test/ui/todo_page/todo_page.dart';
import 'package:notion_api_test/view_model/user_data_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NotionApp'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<UserDataViewModel>().logOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: Text('Todo'),
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TodoPage()));
                });
              },
            ),
            ListTile(
              leading: Text('Calender'),
              onTap: () {
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CalenderPage(DateTime.now())));
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}