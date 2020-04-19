class IndiaCase {

  String active;
  String confirmed;
  String deaths;
  String recovered;
  String deltaConfirmed;
  String deltaDeaths;
  String deltaRecovered;
  String placeName;

  IndiaCase({
      this.active,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.deltaConfirmed,
      this.deltaDeaths,
      this.deltaRecovered,
      this.placeName});

  factory IndiaCase.fromMap(Map<String, dynamic> map){
    return IndiaCase(
        active : map['active'],
        confirmed : map['confirmed'],
        deaths : map['deaths'],
        recovered : map['recovered'],
        deltaConfirmed : map['deltaconfirmed'],
        deltaDeaths : map['deltadeaths'],
        deltaRecovered : map['deltarecovered'],
        placeName : map['state']
    );
  }
}

abstract class IndiaCasesRepository {
  Future<List<IndiaCase>> fetchIndiaCases();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Error While Fetching India Case";
    return _message;
  }
}
