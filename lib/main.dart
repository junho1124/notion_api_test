import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notion_api_test/view_model/calender_view_model.dart';
import 'package:notion_api_test/view_model/todo_view_model.dart';
import 'package:notion_api_test/ui/calender_page/calender_page.dart';
import 'package:provider/provider.dart';
import 'ui/todo/todo_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(MultiProvider(
      providers: [
    ChangeNotifierProvider(create: (_) => TodoViewModel()),
    ChangeNotifierProvider(create: (_) => CalenderViewModel()),
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
      home: MainPage()
    );
  }
}

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

