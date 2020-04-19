import 'package:covidanalyser/model/CountryName.dart';
import 'package:covidanalyser/util/Const.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FetchCountryName implements CountryNameRepository{

  @override
  Future<List<CountryName>> fetchCountryName() async{
    http.Response response = await http.get(CountryNameUrl);

    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException("Error While Fetching Country Name : [Status Code : $statusCode]");
    }

    return responseBody.map((m) => CountryName.fromMap(m)).toList();
  }
}