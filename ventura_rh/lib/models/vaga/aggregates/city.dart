import 'State.dart';

class City {
  City({this.name, State state}) {
    _state = state;
    this.toString();
  }
  String name;
  State _state;

  State set(State state) {
    _state = state;
  }

  State get() {
    return _state;
  }
}
