part of 'profile_update_bloc.dart';


enum UpdateProfileStatus { initial, fetchedToken, loading, loaded, error }

class UpdateProfileState extends Equatable {
  final UpdateProfileStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;

  const UpdateProfileState({
    this.status = UpdateProfileStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,

  });


  UpdateProfileState copyWith({
    UpdateProfileStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
  }) {
    return UpdateProfileState(
      status: status ?? this.status,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object?> get props => [
    status,
    isFirstTime,
    isAuthenticated,
  ];
}