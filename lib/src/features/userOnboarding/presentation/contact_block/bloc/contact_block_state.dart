part of 'contact_bloc.dart';

enum ContactBlockStatus { initial,
  error,
  loaded
}

class ContactBlockState extends Equatable {
  final ContactBlockStatus status;

  const ContactBlockState({
    this.status = ContactBlockStatus.initial,

  });


  ContactBlockState copyWith({
    ContactBlockStatus? status,
    int? token
  }) {
    return ContactBlockState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    status,
  ];
}

