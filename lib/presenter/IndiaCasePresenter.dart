import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/util/DependencyInjection.dart';

abstract class IndiaCaseViewContract {
  void onLoadIndiaCases(List<IndiaCase> indiaCase);

  void onLoadException(String error);
}

class IndiaCaseListPresenter {
  IndiaCaseViewContract _view;
  IndiaCasesRepository _repository;

  IndiaCaseListPresenter(this._view) {
    _repository = Injector().indiaCaseRepository;
  }

  void loadIndiaCase() {
    _repository
        .fetchIndiaCases()
        .then((value) => _view.onLoadIndiaCases(value))
        .catchError((onError) => _view.onLoadException(onError.toString()));
  }
}
