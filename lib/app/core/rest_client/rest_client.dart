import 'package:get/get.dart';

class RestClient extends GetConnect {

  final _backendBaseUrl = "http://dartweek.academiadoflutter.com.br/";

  RestClient() {
    httpClient.baseUrl = _backendBaseUrl;
  }
}