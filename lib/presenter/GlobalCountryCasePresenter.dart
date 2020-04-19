import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/util/DependencyInjection.dart';

abstract class CountryCaseListViewContract {
  void onLoadCountryCaseList(List<CountryCaseList> countryCaseList);

  void onLoadException(String error);
}

class CountryCaseListPresenter {
  CountryCaseListViewContract _view;
  CountryCaseListRepository _repository;

  CountryCaseListPresenter(this._view) {
    _repository = Injector().countryCaseListRepository;
  }

  void loadCountryCaseList(String slag) {
    _repository
        .fetchCountryCaseList(slag)
        .then((value) => _view.onLoadCountryCaseList(value))
        .catchError((onError) => _view.onLoadException(onError.toString()));
  }
}
