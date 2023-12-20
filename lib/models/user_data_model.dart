class UserDataModel {
  String? name;
  String? surName;
  String? gender;
  String? age;
  String? id;

  UserDataModel({this.name, this.surName, this.gender, this.age, this.id});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surName = json['surname'];
    gender = json['gender'];
    age = json['age'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['surname'] = surName;
    data['gender'] = gender;
    data['age'] = age;
    data['id'] = id;
    return data;
  }
}
