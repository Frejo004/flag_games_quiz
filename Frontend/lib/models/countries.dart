import 'dart:convert';
import 'package:http/http.dart' as http;

class Country {
  final String name;
  final String flag;
  final String capital;

  Country({required this.name, required this.flag, required this.capital});

  factory Country.fromJson(Map<String, dynamic> json) {
    // Safely extracting the name, flag, and capital
    final name = json['translations']?['fra']?['common'] ?? 'Unknown';
    final flag = json['flags']?['png'] ?? 'https://via.placeholder.com/150'; 
    final capital = json['capital']?.isNotEmpty ?? false ? json['capital'][0] : 'Unknown';

    return Country(
      name: name,
      flag: flag,
      capital: capital,
    );
  }
}

Future<List<Country>> fetchCountries() async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Country.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load countries');
  }
}
