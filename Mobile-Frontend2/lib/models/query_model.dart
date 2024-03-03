class QueryModel {
  String? prob;
  String? email;
  String? name;

  QueryModel({
    this.prob,
    this.email,
    this.name,
  });

  QueryModel.fromJson(Map<String, dynamic> json) {
    prob = json['problem'];
    email = json['email'];
    name = json['name'];
  }
}
