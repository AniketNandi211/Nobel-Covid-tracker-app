// obsolete class
import 'package:flutter/foundation.dart';

class Country{

  final String name;
  final String slug;
  final String code;

  Country({
    @required this.name,
    @required this.slug,
    @required this.code,
  });

  factory Country.withJson(Map<String, dynamic> jsonData) {
    return Country(
      name: jsonData['Country'] ?? 'n/p',
      slug: jsonData['Slug'] ?? 'n/p',
      code: jsonData['ISO2'] ?? 'n/p'
    );
  }

}