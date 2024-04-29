

import 'package:injectable/injectable.dart';
import 'package:unswipe/data/api_response.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/models/block_contact/block_contact_response.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/models/upload_image_response/upload_image_response.dart';

import '../../domain/repository/on_boarding_user_repository.dart';
import '../datasources/network/service/user_onboarding_service.dart';

@Injectable(as: UserOnboardingRepository)
class UserOnboardingRepositoryImpl implements UserOnboardingRepository {

  final UserOnboardingService services;

  UserOnboardingRepositoryImpl(
      this.services,
      );

  @override
  Future<ApiResponse<BlockContactResponse>> blockUsers() {
    // TODO: implement blockUsers
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<UploadImageResponse>> uploadImages() {
    // TODO: implement uploadImages
    throw UnimplementedError();
  }


  }

