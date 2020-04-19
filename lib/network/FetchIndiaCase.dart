import 'package:covidanalyser/model/IndiaCase.dart';
import 'package:covidanalyser/util/Const.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FetchIndiaCase implements IndiaCasesRepository {

  @override
  Future<List<IndiaCase>> fetchIndiaCases() async{
    http.Response response = await http.get(IndiaCaseUrl);

    final List responseBody = json.decode(response.body)['statewise'];
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException("Error While Fetching India Case : [Status Code : $statusCode]");
    }

    return responseBody.map((m) => IndiaCase.fromMap(m)).toList();
  }
}