import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_skip.dart';

import '../../domain/repository/profile_swipe_repository.dart';
import '../datasources/network/profile_swipe_service.dart';
import '../model/get_profile/response_profile_swipe.dart';

@Injectable(as: ProfileSwipeRepository)
class ProfileSwipeRepositoryImpl implements ProfileSwipeRepository {
  final ProfileSwipeService services;

  ProfileSwipeRepositoryImpl(
    this.services,
  );

  @override
  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(
      String token, ProfileSwipeParams params) async {
    final response = await services.getProfiles(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseProfileSwipe;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }

  @override
  Future<ApiResponse<ResponseProfileSwipe>> getRequestedProfiles(
      String token, ProfileSwipeParams params) async {
    final response = await services.getRequestedProfiles(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseProfileSwipe;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }

  @override
  Future<ApiResponse<ResponseProfileRequest>> createRequest(
      String token, ProfileSwipeParams params) async {
    final response = await services.createProfiles(token, params);
    if (response is Success) {
      try {
        final result =
            (response as Success).data as ResponseProfileRequest;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }

  @override
  Future<ApiResponse<ResponseProfileRequest>> acceptRequest(
      String token, ProfileSwipeParams params) async {
    final response = await services.acceptProfiles(token, params);
    if (response is Success) {
      try {
        final result =
        (response as Success).data as ResponseProfileRequest;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }

  @override
  Future<ApiResponse<ResponseProfileRequest>> rejectRequest(
      String token, ProfileSwipeParams params) async {
    final response = await services.rejectProfiles(token, params);
    if (response is Success) {
      try {
        final result =
            (response as Success).data as ResponseProfileRequest;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }
  }

  @override
  Future<ApiResponse<ResponseProfileSkip>> skipRequest(String token, ProfileSwipeParams params) async{
    // TODO: implement skipRequest
    final response = await services.skipProfiles(token, params);
    if (response is Success) {
      try {
        final result =
        (response as Success).data as ResponseProfileSkip;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else if (response is OperationFailure) {
      return OperationFailure(error: (response as OperationFailure).error);
    } else {
      return Failure(error: (response as Failure).error);
    }  }
}
