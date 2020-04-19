import 'package:covidanalyser/model/CountryCaseList.dart';
import 'package:covidanalyser/model/Link.dart';

const String CountryNameUrl = "https://api.covid19api.com/countries";
const String GlobalCaseUrl = "https://api.covid19api.com/summary";
const String CountryCaseListUrl = "https://api.covid19api.com/dayone/country/";
const String IndiaCaseUrl = "https://api.covid19india.org/data.json";

final List<String> symptomsImage = [
  "images/fever.png",
  "images/cough.png",
  "images/shortness_of_breath.png",
  "images/sore_throat.png",
  "images/headache.png"
];

final List<String> symptomsText = [
  "Fever",
  "Cough",
  "Shortness Of Breath",
  "Sore Throat",
  "Headache"
];

final List<String> preventionImage = [
  "images/stay_home.png",
  "images/distancing.png",
  "images/handshake.png",
  "images/wash.png",
  "images/gathering.png",
  "images/work_from_home.png",
  "images/social_distancing.png",
  "images/face.png",
  "images/mask.png",
  "images/travel.png",
  "images/news.png",
  "images/rumors.png",
];

final List<String> preventionText = [
  "Stay At Home",
  "Maintain Social Distancing",
  "Avoid HandShake",
  "Wash Your Hand Reguarly",
  "Avoid Crowded Place",
  "Try To Work From Home If Possible",
  "Avoid Contact With Sick People",
  "Don't Touch Your Face",
  "Wear Mask",
  "Avoid Travelling To Affectected Areas",
  "Follow News By The Government",
  "Stop Spreading Fake News",
];

final List<String> infectedImage = [
  "images/call_doctor.png",
  "images/stay_home.png",
  "images/social_distancing.png",
  "images/tissue.png"
];

final List<String> infectedText = [
  "Contact Doctor Instantly",
  "Stay At Home",
  "Avoid Contact With Others",
  "Cover Your Nose And Mouth With Tissue Or Elbow While Sneezing",
];

List<Link> linkList = [
  Link("Arogya Setu", "https://play.google.com/store/apps/details?id=nic.goi.aarogyasetu", "images/playstore.png"),
  Link("Arogya Setu", "https://apps.apple.com/in/app/aarogyasetu/id1505825357", "images/app_store.png"),
  Link("MoHFW", "https://www.mohfw.gov.in/", "images/internet.png"),
  Link("MoHFW", "https://twitter.com/MoHFW_INDIA", "images/twitter.png"),
  Link("WHO", "https://twitter.com/who", "images/twitter.png"),
  Link("WHO", "https://www.who.int/", "images/internet.png"),
  Link("WHO", "https://www.youtube.com/channel/UC07-dOwgza1IguKA86jqxNA", "images/youtube.png"),
  Link("Ministry Of Ayush", "https://www.ayush.gov.in/", "images/internet.png"),
  Link("Ministry Of Ayush", "https://twitter.com/moayush", "images/twitter.png")
];

bool equalsIgnoreCase(String string1, String string2) {
  return string1.trim()?.toLowerCase() == string2.trim()?.toLowerCase();
}

String convertStrToDate(String str) {
  String year = str.substring(0, 4);
  String month = str.substring(5, 7);
  String day = str.substring(8, 10);
  return day + "/" + month + "/" + year;
}

List<CountryCaseList> reverseList(List<CountryCaseList> countryCaseList) {
  int l = 0, h = countryCaseList.length - 1;
  while (l < h) {
    CountryCaseList temp = countryCaseList[l];
    countryCaseList[l] = countryCaseList[h];
    countryCaseList[h] = temp;
    l++;
    h--;
  }

  return countryCaseList;
}

List<CountryCaseList> combineListElement(
    List<CountryCaseList> countryCaseList) {
  for (int i = 1; i < countryCaseList.length; i++) {
    if (countryCaseList[i].date == countryCaseList[i - 1].date) {
      countryCaseList[i - 1].confirmed =
          (int.parse(countryCaseList[i - 1].confirmed) +
                  int.parse(countryCaseList[i].confirmed))
              .toString();
      countryCaseList[i - 1].deaths =
          (int.parse(countryCaseList[i - 1].deaths) +
                  int.parse(countryCaseList[i].deaths))
              .toString();
      countryCaseList[i - 1].recovered =
          (int.parse(countryCaseList[i - 1].recovered) +
                  int.parse(countryCaseList[i].recovered))
              .toString();

      countryCaseList.removeAt(i);
      i--;
    }
  }

  return countryCaseList;
}
