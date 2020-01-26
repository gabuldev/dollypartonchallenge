import 'package:rxdart/rxdart.dart';

class PhotoContainerBloc {
  PhotoContainerBloc() {
    photoOut = _photo.stream;
    _photoIn = _photo.sink;
  }

  var _photo = BehaviorSubject<String>();
  Stream<String> photoOut;
  Sink<String> _photoIn;

  void add(String file) => _photoIn.add(file);

  void dispose() {
    _photo.close();
    _photoIn.close();
  }
}
