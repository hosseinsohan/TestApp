class QuizListModel {
  int id;
 String name;

  void setId(int id) {
    this.id = id;
  }

  int get getId => id;

  QuizListModel({this.name, });

  factory QuizListModel.fromJson(Map<String, dynamic> json) {
    return QuizListModel(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}