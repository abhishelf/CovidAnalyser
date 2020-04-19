import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/util/DependencyInjection.dart';

abstract class CountryNameViewContract {
  void onLoadCountryName(List<CountryName> countryName);

  void onLoadException(String error);
}

class CountryNamePresenter {
  CountryNameViewContract _view;
  CountryNameRepository _repository;

  CountryNamePresenter(this._view) {
    _repository = Injector().countryNameRepository;
  }

  void loadCountryName() {
    _repository
        .fetchCountryName()
        .then((value) => _view.onLoadCountryName(value))
        .catchError((onError) => _view.onLoadException(onError.toString()));
  }
}
