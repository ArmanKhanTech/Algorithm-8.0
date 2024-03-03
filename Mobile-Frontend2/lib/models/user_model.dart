class UserModel {
  String? name;
  String? email;
  String? type;
  String? id;

  UserModel({
    this.name,
    this.email,
    this.type,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    type = json['type'];
    id = json['id'];
  }
}
