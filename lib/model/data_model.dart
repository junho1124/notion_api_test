
class Data {
  final String name;
  final String status;
  final DateTime startDate;
  final DateTime endDate;
  final String details;
  final String pageID;

  const Data({
    required this.name,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.details,
    required this.pageID
  });

  factory Data.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final id = map['id'] as String;
    final status = properties['status']?['select']['name'];
    final nameList = (properties['name']?['title'] ?? []) as List;
    final detailList = (properties['details']?['rich_text'] ?? []) as List;
    final startDateStr = properties['deadline']?['date']?['start'];
    final endDateStr = properties['deadline']?['date']?['start'];
    return Data(
        name: nameList.isNotEmpty ? nameList[0]['plain_text'] : '?',
        status: status != null ? status : 'Any',
        startDate: startDateStr != null ? DateTime.parse(startDateStr) : DateTime.now(),
        endDate: endDateStr != null ? DateTime.parse(endDateStr) : DateTime.now(),
        details: detailList.isNotEmpty ? detailList[0]['plain_text'] : 'any',
        pageID: id
    );
  }


}