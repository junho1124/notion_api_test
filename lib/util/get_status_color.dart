import 'package:flutter/material.dart';

Color getStatusColor(String status) {
  switch (status) {
    case '진행중':
      return Colors.blue[400]!;
    case '완료':
      return Colors.green[400]!;
    case '시작전':
      return Colors.red[400]!;
    default:
      return Colors.orange;
  }
}