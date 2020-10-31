import 'City.dart';

class State {
  State({this.name, this.initials, City city}) {
    this.cities.add(city);
    this.toString();
  }
  String name;
  String initials;
  List<City> cities = [];
}
