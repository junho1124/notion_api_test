import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:notion_api_test/model/result.dart';

class DeleteRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  DeleteRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<void> deleteTodoItem(String pageId, String token) async {
    Map<String, dynamic> input = {
      "archived": true,
    };
    final body = jsonEncode(input);
    print(body);
    try {
      final url = Uri.parse('${_baseUrl}pages/$pageId');
      final response = await _client.patch(url,
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer $token',
            HttpHeaders.connectionHeader: 'keep-alive',
            HttpHeaders.acceptEncodingHeader: 'gzip, deflate, br',
            HttpHeaders.acceptHeader: '*/*',
            HttpHeaders.contentTypeHeader: 'application/json',
            'Notion-Version': '2021-05-13'
          },
          body: body);
      if (response.statusCode == 200) {
        print('삭제 완료');
      } else {
        throw Result.error('오류');
      }
    } catch (_) {
      print('err 4');
      throw Result.error('오류');
    }
  }
}
