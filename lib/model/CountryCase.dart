class CountryCase {
  String countryConfirmed;
  String countryDeath;
  String countryRecovered;
  String deltaCountryConfirmed;
  String deltaCountryDeath;
  String deltaCountryRecovered;
  String countryName;
  String countrySlug;

  CountryCase(
      this.countryConfirmed,
      this.countryDeath,
      this.countryRecovered,
      this.deltaCountryConfirmed,
      this.deltaCountryDeath,
      this.deltaCountryRecovered,
      this.countryName,
      this.countrySlug);

  CountryCase.fromMap(Map<String, dynamic> map)
      : countryConfirmed = map['TotalConfirmed'].toString(),
        countryDeath = map['TotalDeaths'].toString(),
        countryRecovered = map['TotalRecovered'].toString(),
        deltaCountryConfirmed = map['NewConfirmed'].toString(),
        deltaCountryDeath = map['NewDeaths'].toString(),
        deltaCountryRecovered = map['NewRecovered'].toString(),
        countryName = map['Country'].toString(),
        countrySlug = map['Slug'].toString();
}
