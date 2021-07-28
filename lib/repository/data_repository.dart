import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../model/failure_model.dart';
import '../model/data_model.dart';

class DataRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  DataRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Data>> getTodoItems() async {
    try {
      final url =
          '${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2021-05-13'
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List).map((e) => Data.fromMap(e)).toList()
          ..sort((a, b) => b.startDate.compareTo(a.startDate));
      } else {
        throw const Failure(message: '데이터 전송 오류');
      }
    } catch (_) {
      throw const Failure(message: '데이터 전송 오류');
    }
  }
  Future<void> createTodoItems(String detail, String status, String color, String startTime, String? endTime, String name) async {
    Map<String, dynamic> body = {
      "parent": {
        "database_id": "33ba8e6b-2552-4cc1-b9c3-021acfc5349c"
      },
      "properties": {
        "details": {
          "id": ":>ca",
          "type": "rich_text",
          "rich_text": [
            {
              "type": "text",
              "text": {
                "content": detail,
                "link": null
              },
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": detail,
              "href": null
            }
          ]
        },
        "status": {
          "id": "SgUA",
          "type": "select",
          "select": {
            "id": "3",
            "name": status,
            "color": color
          }
        },
        "deadline": {
          "id": "|VoD",
          "type": "date",
          "date": {
            "start": startTime,
            "end": endTime
          }
        },
        "name": {
          "id": "title",
          "type": "title",
          "title": [
            {
              "type": "text",
              "text": {
                "content": name,
                "link": null
              },
              "annotations": {
                "bold": false,
                "italic": false,
                "strikethrough": false,
                "underline": false,
                "code": false,
                "color": "default"
              },
              "plain_text": name,
              "href": null
            }
          ]
        }
      }
    };
    print('$detail, $status, $color, $startTime, $endTime, $name');
    try {
      final url = '${_baseUrl}pages';
      final response = await _client.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${dotenv.env['NOTION_API_KEY']}',
            HttpHeaders.connectionHeader : 'keep-alive',
            HttpHeaders.acceptEncodingHeader : 'gzip, deflate, br',
            HttpHeaders.acceptHeader : '*/*',
            HttpHeaders.contentTypeHeader: 'application/json',
            'Notion-Version': '2021-05-13'
          },
          body: body);
      print('err 1');
      if (response.statusCode == 200) {
      print('err 2');
        print('데이터 전송 완료');
      } else {
        print('err 3');
        throw const Failure(message: '데이터 전송 오류');
      }
    } catch (_) {
      print('err 4');
      throw const Failure(message: '데이터 전송 오류!!');
    }
  }
}
