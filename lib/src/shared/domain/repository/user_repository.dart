import 'dart:io';

import '../../../core/app_error.dart';
import '../entities/auth_state.dart';
import '../entities/onbaording_state/onboarding_state.dart';



abstract class UserRepository {
  Stream<Result<AuthenticationState>> get authenticationState$;



// UnitResultSingle login({
  //   required String email,
  //   required String password,
  // });
  //
  // UnitResultSingle registerUser({
  //   required String name,
  //   required String email,
  //   required String password,
  // });
  //
  // UnitResultSingle logout();
  //
  // UnitResultSingle uploadImage(File image);
  //
  // UnitResultSingle changePassword({
  //   required String password,
  //   required String newPassword,
  // });
  //
  // UnitResultSingle resetPassword({
  //   required String email,
  //   required String token,
  //   required String newPassword,
  // });
  //
  // UnitResultSingle sendResetPasswordEmail(String email);
}
