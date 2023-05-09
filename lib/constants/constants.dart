// ignore_for_file: constant_identifier_names

import '../api/urls.dart';

class Constants {
  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String API_KEY = "de6ee22513b9ec1722f4a5c34693f4bf";
}

extension S on String {
  String toNetworkImagePath() => "${Urls.image_base_url}$this";
}
