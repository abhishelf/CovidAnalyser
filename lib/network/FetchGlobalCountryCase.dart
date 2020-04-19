import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/util/Const.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FetchGlobalCountryCase implements CountryCaseListRepository {

  @override
  Future<List<CountryCaseList>> fetchCountryCaseList(String countrySlag) async{
    http.Response response = await http.get(CountryCaseListUrl+countrySlag);
    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;


    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException("Error While Fetching Global Country Case : [Status Code : $statusCode]");
    }

    return responseBody.map((m) => CountryCaseList.fromMap(m)).toList();
  }

}