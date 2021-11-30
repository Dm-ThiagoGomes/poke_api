import 'dart:async';

class SearchBloc {
  final StreamController<String> _streamController = StreamController<String>();
  Sink<String> get input => _streamController.sink;
  Stream get output => _streamController.stream.asyncMap((event) => null);

  
}
