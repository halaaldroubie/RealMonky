import 'dart:convert';

class CategoryModel {
  int? id;
  String? name;
  String? logo;

  CategoryModel({
    this.id,
    this.name,
    this.logo,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;

    return data;
  }

  //  static String encode(List<CategoryModel> list) => json.encode(
  //       list
  //           .map<Map<String, dynamic>>((element) => CategoryModel.toMap(element))
  //           .toList(),
  //     );

  // static List<CategoryModel> decode(String strList) =>
  //     (json.decode(strList) as List<dynamic>)
  //         .map<CategoryModel>((item) => CategoryModel.fromJson(item))
  //         .toList();
}
