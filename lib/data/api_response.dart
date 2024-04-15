abstract class ApiResponse<T> {}

class Success<T> extends ApiResponse<T> {
  T? data;

  Success({required this.data});
}

class Failure<T> extends ApiResponse<T> {
  Exception error;


  Failure({required this.error});
}

class CancelTokenFailure<T> extends Failure<T> {
  CancelTokenFailure({required super.error});
}
