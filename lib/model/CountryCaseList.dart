class CountryCaseList {

  String country;
  String confirmed;
  String deaths;
  String recovered;
  String province;
  String date;

  CountryCaseList({this.country, this.confirmed, this.deaths, this.recovered,this.province,this.date});

  factory CountryCaseList.fromMap(Map<String, dynamic> map){
    return CountryCaseList(
      country: map['Country'],
      confirmed: map['Confirmed'].toString(),
      deaths: map['Deaths'].toString(),
      recovered: map['Recovered'].toString(),
      province: map['Province'].toString(),
      date: map['Date']
    );
  }
}

abstract class CountryCaseListRepository {
  Future<List<CountryCaseList>> fetchCountryCaseList(String countrySlag);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Error While Fetching Country Case List";
    return _message;
  }
}
