// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notion_api_test/model/data_model.dart';
import 'package:http/http.dart' as http;

import 'package:notion_api_test/main.dart';

void main() {
  test('http 통신 테스트', () async {
    String _baseUrl = 'https://api.notion.com/v1/';

    var uri = Uri.parse('${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query');
    var response = await http.post(
        uri,
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version' : '2021-05-13',
        });
    expect(response.statusCode, 200);

    // final result = json.decode(response.body) as Map<String, dynamic>;
    // List data = (result['results'] as List).map((e) => Item.fromMap(e)).toList()
    // ..sort((a, b) => b.deadline.compareTo(a.deadline));
    //
    //
    // expect(result.result[0].imageId, 2131165292);
    print((((json.decode(response.body) as Map<String, dynamic>)['results']) as List).map((e) => Data.fromMap(e)).toList()[1].name);

  });
}
