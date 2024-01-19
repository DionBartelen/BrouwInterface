import 'dart:async';

class NewDataNotifier {
  static final _dataController = StreamController<bool>.broadcast();
  static Stream<bool> get dataStream => _dataController.stream;

  static void notify() {
    _dataController.sink.add(true);
  }

  static void dispose() {
    _dataController.close();
  }
}