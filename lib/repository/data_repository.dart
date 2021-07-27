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

  Future<void> createTodoItems(String pageUrl, String title, String status, String color, DateTime startTime, DateTime endTime, String name) async {
    try {
      final url =
          '${_baseUrl}pages';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
          'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2021-05-13'
        },
        body: {
          'parent' : {'database_id' : '${dotenv.env['NOTION_DATABASE_ID']}'},
          'properties' : {
            'details' : {
              'rich_text' : [
                {
                  'plain_text' : title
                }
              ]
            },
            'status' : {
              'select' : {
                'name' : status,
                'color' : color
              }
            },
            'deadline' : {
              'date' : {
                'start' : startTime,
                'end' : endTime
              }
            },
            'name' : {
              'title' : [
                {
                  'plain_text' : name
                }
              ]
            }
          }
        }
      );

      if (response.statusCode == 200) {
          print('데이터 전송 완료');
      } else {
        throw const Failure(message: '데이터 전송 오류');
      }
    } catch (_) {
      throw const Failure(message: '데이터 전송 오류');
    }
  }

}