import 'package:cloud_firestore/cloud_firestore.dart';

class EvalModel {
  String? id;
  String? judgeName;
  String? teamName;

  Timestamp? evaluatedAt;

  int? solution;
  int? presentation;
  int? completion;
  int? teamwork;
  int? socialImpact;
  int? scalability;
  int? uiUx;
  int? usp;
  int? fossImpact;

  int? totalMarks;

  EvalModel(
      {this.id,
      this.judgeName,
      this.teamName,
      this.evaluatedAt,
      this.solution,
      this.presentation,
      this.completion,
      this.teamwork,
      this.socialImpact,
      this.scalability,
      this.uiUx,
      this.usp,
      this.fossImpact,
      this.totalMarks});

  EvalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judgeName = json['judgeName'];
    teamName = json['teamName'];
    evaluatedAt = json['evaluatedAt'];
    solution = json['solution'];
    presentation = json['presentation'];
    completion = json['completion'];
    teamwork = json['teamwork'];
    socialImpact = json['socialImpact'];
    scalability = json['scalability'];
    uiUx = json['uiUx'];
    usp = json['usp'];
    fossImpact = json['fossImpact'];
    totalMarks = json['totalMarks'];
  }
}
