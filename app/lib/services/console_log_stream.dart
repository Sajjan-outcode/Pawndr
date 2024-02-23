import 'dart:async';

class ConsoleLogStream {
  static final ConsoleLogStream _instance = ConsoleLogStream._internal();
  List<String> myList = [];
  factory ConsoleLogStream() => _instance;

  ConsoleLogStream._internal();

  final StreamController<List<String>> _dataStreamController =
      StreamController<List<String>>.broadcast();
  Stream<List<String>> get dataStream => _dataStreamController.stream;

  void updateData(String newData) {
    myList.add(newData);
    _dataStreamController.add(myList);
  }

  void dispose() {
    _dataStreamController.close();
  }
}
