class Country {
  final String name;
  final String nameForJpSearch;
  final String isoCode;
  final String iso3Code;
  final String phoneCode;
  final List<String> continents;

  Country({this.isoCode, this.iso3Code, this.phoneCode, this.name, this.nameForJpSearch, this.continents});

//  factory Country.fromMap(Map<String, String> map) => Country(
//        name: map['name'],
//        jpName: map['jpName'],
//        isoCode: map['isoCode'],
//        iso3Code: map['iso3Code'],
//        phoneCode: map['phoneCode'],
//      );
}
