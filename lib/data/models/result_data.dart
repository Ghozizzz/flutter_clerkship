class ResultData<T> {
  final T? data;
  final String? unexpectedErrorMessage;
  final int statusCode;

  ResultData({
    this.data,
    this.unexpectedErrorMessage,
    required this.statusCode,
  });
}
