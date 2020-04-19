import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/util/DependencyInjection.dart';

abstract class GlobalCaseViewContract {
  void onLoadGlobalCases(GlobalCase globalCase);

  void onLoadException(String error);
}

class GlobalCaseListPresenter {
  GlobalCaseViewContract _view;
  GlobalCaseRepository _repository;

  GlobalCaseListPresenter(this._view) {
    _repository = Injector().globalCaseRepository;
  }

  void loadGlobalCase() {
    _repository
        .fetchGlobalCase()
        .then((value) => _view.onLoadGlobalCases(value))
        .catchError((onError) => _view.onLoadException(onError.toString()));
  }
}
