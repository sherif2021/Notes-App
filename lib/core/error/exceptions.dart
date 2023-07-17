class LocalStorageException implements Exception {}

class CustomException implements Exception {
  final String message;

  CustomException(this.message);
}

class InternetException implements Exception {}