// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'treinamento1_cubit.dart';

class Treinamento1State {
  final List<Treinamento1Model> list;

  Treinamento1State({
    this.list = const [],
  });

  Treinamento1State copyWith({
    List<Treinamento1Model>? list,
  }) {
    return Treinamento1State(
      list: list ?? this.list,
    );
  }
}
