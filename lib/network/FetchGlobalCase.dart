import 'package:covidanalyser/model/GlobalCase.dart';
import 'package:covidanalyser/util/Const.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FetchGlobalCase implements GlobalCaseRepository {

  @override
  Future<GlobalCase> fetchGlobalCase() async{
    http.Response response = await http.get(GlobalCaseUrl);
    var responseBody = json.decode(response.body);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException("Error While Fetching Global Case : [Status Code : $statusCode]");
    }

    return GlobalCase.fromMap(responseBody);
  }
}