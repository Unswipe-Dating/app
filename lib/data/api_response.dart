import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ApiResponse<T> {}

class Success<T> extends ApiResponse<T> {
  T? data;

  Success({required this.data});
}

class Failure<T> extends ApiResponse<T> {
  Exception error;


  Failure({required this.error});
}

class OperationFailure<T> extends ApiResponse<T> {
  OperationException? error;
  OperationFailure({this.error});
}

class TimeOutFailure<T> extends ApiResponse<T> {
  TimeOutFailure();
}

class NoNetworkFailure<T> extends ApiResponse<T> {
  NoNetworkFailure();
}

class AuthorizationFailure<T> extends ApiResponse<T> {
  OperationException? error;


  AuthorizationFailure({this.error});
}

class CancelTokenFailure<T> extends Failure<T> {
  CancelTokenFailure({required super.error});
}
