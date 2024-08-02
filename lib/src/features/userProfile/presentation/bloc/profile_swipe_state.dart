import 'package:equatable/equatable.dart';
import 'package:unswipe/src/chat/chat.dart';
import 'package:unswipe/src/features/userProfile/data/model/create_request/response_profile_request.dart';

import '../../data/model/get_profile/response_profile_swipe.dart';

enum ProfileSwipeStatus { initial,
  fetchedToken,
  loading,
  loaded,
  loadedCreate,
  loadedReject,
  loadedAccept,
  loadedSkip,
  error,
  errorAuth,
  errorTimeOut,
errorSwipe,
  loadedChat
}

class ProfileSwipeState extends Equatable {
  final ProfileSwipeStatus status;
  final ResponseProfileRequest? request;
  final ResponseProfileSwipe? responseProfileSwipe;
  final ChatPageParams? chatParams;


  const ProfileSwipeState({
    this.status = ProfileSwipeStatus.initial,
    this.responseProfileSwipe,
    this.request,
    this.chatParams,

  });




  ProfileSwipeState copyWith({
    ProfileSwipeStatus? status,
    final ResponseProfileSwipe? responseProfileSwipe,
    ResponseProfileRequest? request,
    ChatPageParams? chatParams,
  }) {
    return ProfileSwipeState(
      status: status ?? this.status,
      responseProfileSwipe: responseProfileSwipe ?? this.responseProfileSwipe,
      request: request?? this.request,
      chatParams: chatParams??this.chatParams,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseProfileSwipe,
    request,
    chatParams,
  ];
}