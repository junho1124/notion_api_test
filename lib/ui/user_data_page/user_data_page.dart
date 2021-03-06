import 'package:flutter/material.dart';
import 'package:notion_api_test/model/result.dart';
import 'package:notion_api_test/view_model/calender_view_model.dart';
import 'package:notion_api_test/view_model/user_data_view_model.dart';
import 'package:provider/provider.dart';

class UserDataPage extends StatefulWidget {
  const UserDataPage({Key? key}) : super(key: key);

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final _tokenController = TextEditingController();
  final _databaseController = TextEditingController();

  @override
  void initState() {
    context.read<UserDataViewModel>();
    super.initState();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    _databaseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<UserDataViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Notion 연결'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text('통합 토큰'),
              Flexible(
                child: TextField(
                  controller: _tokenController,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('데이터베이스 ID'),
              Flexible(
                child: TextField(
                  controller: _databaseController,
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                context
                    .read<CalenderViewModel>()
                    .makeEvent(_tokenController.text, _databaseController.text)
                    .then((value) {
                  if (value is Error) {
                    showAlertDialog(context, value.e);
                  } else {
                    viewModel.login();
                  }
                });
              },
              child: Text('다음'))
        ],
      ),
    );
  }

  Future<dynamic> showAlertDialog(BuildContext context , String error) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(error),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('확인'))
              ],
            ));
  }
}
