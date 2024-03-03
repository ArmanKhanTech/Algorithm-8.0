class AnnModel {
  String? ann;
  String? name;

  AnnModel({
    this.ann,
    this.name,
  });

  AnnModel.fromJson(Map<String, dynamic> json) {
    ann = json['announcement'];
    name = json['name'];
  }
}
