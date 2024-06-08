part of 'profile_update_bloc.dart';


enum UpdateProfileStatus { initial, fetchedToken, loading, loaded, error, errorAuth, errorTimeOut,  }

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;
  final ResponseProfileList? responseProfileList;


  const UpdateProfileState({
    this.status = UpdateProfileStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,
    this.responseProfileList,


  });


  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
    ResponseProfileList? responseProfileList
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        responseProfileList: responseProfileList?? this.responseProfileList
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
    responseProfileList
  ];
}