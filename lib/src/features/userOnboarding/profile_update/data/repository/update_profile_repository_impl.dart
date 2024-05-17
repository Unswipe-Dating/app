

import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/image_upload/data/model/response_image_upload.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';

import '../../domain/repository/update_profile_repository.dart';
import '../datasources/network/service/profile_update_service.dart';
import '../models/create_profile_response.dart';

@Injectable(as: UpdateProfileRepository)
class UpdateProfileRepositoryImpl implements UpdateProfileRepository {

  final UpdateUserService services;

  UpdateProfileRepositoryImpl(
      this.services,
      );

  @override
  Future<ApiResponse<UpdateProfileResponse>> updateUser(String token, UpdateProfileParams params) async {
    final response = await services.updateUser(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as UpdateProfileResponse;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }

  @override
  Future<ApiResponse<CreateProfileResponse>> createUser(String token, UpdateProfileParams params) async {
    final response = await services.createUser(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as CreateProfileResponse;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }

  }

