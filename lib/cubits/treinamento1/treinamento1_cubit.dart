import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treinamento1/models/treinamento1_model.dart';
import 'package:treinamento1/services/db_service.dart';
import 'package:uuid/uuid.dart';

part 'treinamento1_state.dart';

class Treinamento1Cubit extends Cubit<Treinamento1State> {
  final DbService dbService;

  Treinamento1Cubit(this.dbService) : super(Treinamento1State());

  void load() {
    final list =
        dbService.values().map((e) => Treinamento1Model.fromJson(e)).toList();
    emit(state.copyWith(list: list));
  }

  void add({
    required String title,
    String? description,
  }) {
    final newItem = Treinamento1Model(
      id: const Uuid().v1(),
      title: title,
      description: description,
    );

    dbService.add(newItem.toJson());
    emit(state.copyWith(list: [...state.list, newItem]));
  }

  void remove(String id) {
    final index = state.list.indexWhere((element) => element.id == id);
    state.list.removeAt(index);
    dbService.delete(index);
    emit(state.copyWith(list: state.list));
  }

  void toggle(String id) {
    final index = state.list.indexWhere((element) => element.id == id);
    final item = state.list[index];
    item.isCheckd = !item.isCheckd;
    state.list[index] = item;
    dbService.putAt(index, item.toJson());
    emit(state.copyWith(list: state.list));
  }
}
