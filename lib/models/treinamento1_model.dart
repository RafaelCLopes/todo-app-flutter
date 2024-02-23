// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Treinamento1Model {
  final String id;
  final String title;
  final String? description;
  bool isCheckd;

  Treinamento1Model({
    required this.id,
    required this.title,
    this.description,
    this.isCheckd = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'isCheckd': isCheckd,
    };
  }

  factory Treinamento1Model.fromMap(Map<String, dynamic> map) {
    return Treinamento1Model(
      id: map['id'] as String,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      isCheckd: map['isCheckd'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Treinamento1Model.fromJson(String source) =>
      Treinamento1Model.fromMap(json.decode(source) as Map<String, dynamic>);
}
