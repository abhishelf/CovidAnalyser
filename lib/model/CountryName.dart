class CountryName {
  String name;
  String slug;
  CountryName({this.name, this.slug});

  factory CountryName.fromMap(Map<String, dynamic> map){
    return CountryName(
      name: map['Country'],
      slug : map['Slug'],
    );
  }
}

abstract class CountryNameRepository {
  Future<List<CountryName>> fetchCountryName();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Error While Fetching Country Name";
    return _message;
  }
}
