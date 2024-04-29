import 'dart:async';

import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/models/block_contact/block_contact_response.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/models/upload_image_response/upload_image_response.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/entities/create_user_request.dart';

import '../../../../../../data/api_response.dart';

abstract class UserOnboardingRepository {
  Future<ApiResponse<BlockContactResponse>> blockUsers();
  Future<ApiResponse<String>> uploadImages();
  Future<ApiResponse<String>> createUser(CreateUserRequest request);
}



