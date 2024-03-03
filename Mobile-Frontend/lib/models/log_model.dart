import 'package:cloud_firestore/cloud_firestore.dart';

class LogModel {
  final String id;
  final DateTime timestamp;
  final String teamName;
  final bool isTeamActivity;
  final List<dynamic> memberName;
  final String activityType;

  const LogModel(
      {required this.id,
      required this.timestamp,
      required this.teamName,
      required this.isTeamActivity,
      required this.memberName,
      required this.activityType});

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
      id: json['id'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      teamName: json['teamName'],
      isTeamActivity: json['isTeamActivity'],
      memberName: json['memberName'],
      activityType: json['activityType']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'timestamp': Timestamp.fromDate(timestamp),
        'teamName': teamName,
        'isTeamActivity': isTeamActivity,
        'memberName': memberName,
        'activityType': activityType
      };
}
