import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:notion_api_test/model/result.dart';
import 'package:notion_api_test/repository/user_data_repository.dart';

import '../model/data_model.dart';

class DataRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  DataRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<Result<List<Data>>> getTodoItems(String token, String db) async {
    try {
      final url =
          '${_baseUrl}databases/$db/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer $token',
          'Notion-Version': '2021-05-13'
        },
      );

      if (response.statusCode == 200) {
        UserDataRepository().putUserData(token, db);
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return Result.success((data['results'] as List).map((e) => Data.fromMap(e)).toList()
          ..sort((a, b) => b.startDate.compareTo(a.startDate)));
      } else {
        throw Result.error('입력값 오류');
      }
    } catch (_) {
      throw Result.error('입력 값 오류');
    }
  }

}
