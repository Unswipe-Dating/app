import 'package:equatable/equatable.dart';

enum ContactBlockStatus { initial, fetchedToken, loading, loaded, error }

class ContactBlockState extends Equatable {
  final ContactBlockStatus status;
  final bool isFirstTime;
  final bool isAuthenticated;

  const ContactBlockState({
    this.status = ContactBlockStatus.initial,
    this.isFirstTime = true,
    this.isAuthenticated = false,

  });


  ContactBlockState copyWith({
    ContactBlockStatus? status,
    bool? isFirstTime,
    bool? isAuthenticated,
  }) {
    return ContactBlockState(
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