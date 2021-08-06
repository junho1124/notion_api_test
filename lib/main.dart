import 'package:flutter/material.dart';
import 'package:notion_api_test/ui/main_page/main_page.dart';
import 'package:notion_api_test/ui/user_data_page/user_data_page.dart';
import 'package:notion_api_test/view_model/calender_view_model.dart';
import 'package:notion_api_test/view_model/create_view_model.dart';
import 'package:notion_api_test/view_model/todo_view_model.dart';
import 'package:notion_api_test/view_model/user_data_view_model.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (_) => TodoViewModel()),
    ChangeNotifierProvider(create: (_) => CalenderViewModel()),
    ChangeNotifierProvider(create: (_) => CreateViewModel()),
    ChangeNotifierProvider(create: (_) => UserDataViewModel()),
      ],
  child: MyApp(),),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notion Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: context.watch<UserDataViewModel>().isLogin ? MainPage() : UserDataPage()
    );
  }
}



