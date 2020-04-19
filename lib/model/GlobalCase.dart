import 'CountryCase.dart';

class GlobalCase {

  String globalConfirmed;
  String globalDeath;
  String globalRecovered;
  String deltaGlobalConfirmed;
  String deltaGlobalDeath;
  String deltaGlobalRecovered;

  List<CountryCase> countryCase;

  GlobalCase(
      this.globalConfirmed,
      this.globalDeath,
      this.globalRecovered,
      this.deltaGlobalConfirmed,
      this.deltaGlobalDeath,
      this.deltaGlobalRecovered,
      this.countryCase);

  GlobalCase.fromMap(Map<String, dynamic> map):
      globalConfirmed = map['Global']['TotalConfirmed'].toString(),
      globalDeath = map['Global']['TotalDeaths'].toString(),
      globalRecovered = map['Global']['TotalRecovered'].toString(),
      deltaGlobalConfirmed = map['Global']['NewConfirmed'].toString(),
      deltaGlobalDeath = map['Global']['NewDeaths'].toString(),
      deltaGlobalRecovered = map['Global']['NewRecovered'].toString(),
      countryCase = List<CountryCase>.from(map['Countries'].map((x) => CountryCase.fromMap(x)));
}

abstract class GlobalCaseRepository {
  Future<GlobalCase> fetchGlobalCase();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Error While Fetching Global Case";
    return "$_message";
  }
}