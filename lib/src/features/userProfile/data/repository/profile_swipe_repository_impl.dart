

import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/datasources/network/contact_bloc_service.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';

import '../../domain/repository/profile_swipe_repository.dart';
import '../datasources/network/profile_swipe_service.dart';
import '../model/response_profile_swipe.dart';


@Injectable(as: ProfileSwipeRepository)
class ProfileSwipeRepositoryImpl implements ProfileSwipeRepository {

  final ProfileSwipeService services;

  ProfileSwipeRepositoryImpl(
      this.services,
      );
  @override
  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(String token, ProfileSwipeParams params) async {
    final response = await services.getProfiles(token, params);
    if (response is Success) {
      try {
        final result = (response as Success).data as ResponseProfileSwipe;
        return Success(data: result);
      } on Exception catch (e, _) {
        return Failure(error: e);
      }
    } else {
      return Failure(error: Exception((response as Failure).error));
    }
  }


}

