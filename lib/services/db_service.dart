import 'package:hive/hive.dart';

class DbService {
  final Box<String> box;
  DbService({required this.box});

  List<String> values() => box.values.toList();

  Future add(String data) async {
    return await box.add(data);
  }

  Future delete(int index) async {
    return await box.deleteAt(index);
  }

  Future putAt(int index, String data) async {
    return await box.putAt(index, data);
  }
}
