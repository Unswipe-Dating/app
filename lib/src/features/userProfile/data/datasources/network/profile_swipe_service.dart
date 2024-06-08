import 'dart:developer';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:unswipe/src/features/login/data/models/request_otp/otp_response.dart';
import 'package:unswipe/src/features/login/data/models/verify_otp/verify_otp_response.dart';
import 'package:unswipe/src/features/login/domain/repository/login_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/data/model/response_contact_block.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';
import 'package:unswipe/src/features/userProfile/data/model/response_profile_skip.dart';
import '../../../../../../../data/api_response.dart';
import '../../../../../core/network/graphql/graphql_service.dart';
import '../../../domain/repository/profile_swipe_repository.dart';
import '../../model/get_profile/response_profile_swipe.dart';

@injectable
class ProfileSwipeService {
  ProfileSwipeService(this.service);

  final GraphQLService service;

  Future<ApiResponse<ResponseProfileSwipe>> getProfiles(
    String token,
    ProfileSwipeParams params,
  ) async {
    const query = '''
    query BrowseProfiles(\$data: UserIdPaginatedArgs!) {
    browseProfiles(data: \$data){
        profiles {
            id
            userId
            name
            interests
            photoURLs
            location
            dob
            datingPreference
            height
            hometown
            location
            zodiac
            languages
        }
        hasNext
        nextCursor
    }
}
''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {
      "data": {"userId": params.userId, "page_size": 10},
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileSwipe? info;
      try {
        info = ResponseProfileSwipe.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<ResponseProfileSwipe>> getRequestedProfiles(
    String token,
    ProfileSwipeParams params,
  ) async {
    const query = '''
    query GetRequestedProfilesForUser(\$data: UserIdPaginatedArgs!) {
    getRequestedProfilesForUser(data: \$data){
        id
        userId
        name
        interests
        photoURLs
        location
        request {
            id
        }
    }
}
''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {
      "data": {"userId": params.userId},
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileSwipe? info;
      try {
        info = ResponseProfileSwipe.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<ResponseProfileRequest>> createProfiles(
    String token,
    ProfileSwipeParams params,
  ) async {
    const query = '''
    mutation CreateRequest( \$data: RequestInput!){
  createRequest(data: \$data) {
    id
    type
    requesterProfileId
    requesteeProfileId
    expiry
    status
    challenge
    challengeVerification
    challengeVerificationStatus
  }
}
''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {
      "data": {
        "type": "HYPER_EXCLUSIVE",
        "requesterProfileId": params.userId,
        "requesteeProfileId": params.matchUserId,
        "status": "ACTIVE"
      },
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileRequest? info;
      try {
        info = ResponseProfileRequest.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<ResponseProfileRequest>> acceptProfiles(
      String token,
      ProfileSwipeParams params,
      ) async {
    const query = '''
  mutation MatchRequest( \$data: MatchRequestInput!){
  matchRequest(data: \$data) {
    id
    type
    requesterProfileId
    requesteeProfileId
    expiry
    status
    challenge
    challengeVerification
    challengeVerificationStatus
  }
}
''';

    final response =
    await service.performMutationWithHeader(token, query, variables: {
      "data": {
        "id": params.matchUserId,
      },
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileRequest? info;
      try {
        info = ResponseProfileRequest.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<ResponseProfileRequest>> rejectProfiles(
    String token,
    ProfileSwipeParams params,
  ) async {
    const query = '''
   mutation RejectRequest( \$data: RejectRequestInput!){
  rejectRequest(data: \$data) {
    id
    type
    requesterProfileId
    requesteeProfileId
    expiry
    status
    challenge
    challengeVerification
    challengeVerificationStatus
  }
}
''';

    final response =
        await service.performMutationWithHeader(token, query, variables: {
      "data": {
        "id": params.matchUserId,
      },
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileRequest? info;
      try {
        info = ResponseProfileRequest.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }

  Future<ApiResponse<ResponseProfileSkip>> skipProfiles(
      String token,
      ProfileSwipeParams params,
      ) async {
    const query = '''
   mutation SkipProfile(\$data: SkipProfileInput!) {
  skipProfile(data: \$data)
  }
''';

    final response =
    await service.performMutationWithHeader(token, query, variables: {
      "data": {
        "id": params.matchUserId,
      },
    });
    log('$response');

    if (!response.hasException) {
      ResponseProfileSkip? info;
      try {
        info = ResponseProfileSkip.fromJson(
          response.data as Map<String, dynamic>,
        );
      } on Exception catch (e) {
        log('error', error: e);
        return Failure(error: Exception(e));
      }
      return Success(data: info);
    } else {
      if(response.exception?.graphqlErrors[0].extensions?['code'] == "UNAUTHENTICATED") {
        return AuthorizationFailure(error: response.exception);
      }
      return OperationFailure(error: response.exception);
    }
  }


}
