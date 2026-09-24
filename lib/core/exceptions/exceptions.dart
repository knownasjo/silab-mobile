class RequestErrorException implements Exception {
  final String message;
  final Object? data;

  RequestErrorException(this.message, {this.data});
}
