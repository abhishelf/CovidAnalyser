import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/network/FetchCountryName.dart';
import 'package:covidanalyser/network/FetchGlobalCase.dart';
import 'package:covidanalyser/network/FetchGlobalCountryCase.dart';
import 'package:covidanalyser/network/FetchIndiaCase.dart';

enum Flavor { MOCK, PROD }

//TODO
class Injector {

  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  IndiaCasesRepository get indiaCaseRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return null;
      default:
        return FetchIndiaCase();
    }
  }

  GlobalCaseRepository get globalCaseRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return null;
      default:
        return FetchGlobalCase();
    }
  }

  CountryNameRepository get countryNameRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return null;
      default:
        return FetchCountryName();
    }
  }

  CountryCaseListRepository get countryCaseListRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return null;
      default:
        return FetchGlobalCountryCase();
    }
  }
}