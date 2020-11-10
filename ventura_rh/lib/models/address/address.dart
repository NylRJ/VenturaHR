class Address {
  Address({this.street, this.number, this.complement, this.district,
      this.zipCode, this.city, this.state, this.lat, this.long});

  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;

  double lat;
  double long;

  Address.fromMap(Map<String,dynamic> data) {
    street = data['street'] as String;
    number = data['number'] as String;
    complement = data['complement'] as String;
    district = data['district'] as String;
    zipCode = data['zipCode'] as String;
    city = data['city'] as String;
    state = data['state'] as String;
    lat = data['lat'] as double;
    long = data['long'] as double;

  }

  @override
  String toString() {
    return 'Address{street: $street, number: $number, complement: $complement, district: $district, zipCode: $zipCode, city: $city, state: $state, lat: $lat, long: $long}';
  }

  Map<String,dynamic>toMap() {
    return{
      'street':street,
      'number':number,
      'complement':complement,
      'district':district,
      'zipCode':zipCode,
      'city':city,
      'state':state,
      'lat':lat,
      'long':long,

    };
  }


}
