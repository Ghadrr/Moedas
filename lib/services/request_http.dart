import 'dart:convert';
import 'package:http/http.dart' as http;

getCotaCoin() async {
  var url = Uri.parse('https://economia.awesomeapi.com.br/all');
  var response = await http.get(url);
  return (jsonDecode(response.body));
}

getEspecifyCotacao(moedas) async {
  String param = moedas.join(',');
  var url = Uri.parse('http://economia.awesomeapi.com.br/json/last/${param}');
  var response = await http.get(url);
  return jsonDecode(response.body);
}