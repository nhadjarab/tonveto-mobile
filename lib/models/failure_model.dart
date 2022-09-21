class Failure {
  Failure({
    this.status,
    this.message,
  });

  int? status;
  String? message;
  factory Failure.createFailure(int status, String? message) => Failure(
        status: status,
        message: message,
      );
}
