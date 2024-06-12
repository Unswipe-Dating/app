
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:unswipe/src/features/login/domain/usecases/request_otp_use_case.dart';
//
// @module
// abstract class UseCaseModule {
//   RequestOtpUseCase get getRequestOtpUseCase =>
//       RequestOtpUseCase(GetIt.instance.get());
//
// }

@module
abstract class RegisterModule {
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  RxSharedPreferences get rxPrefs => RxSharedPreferences.getInstance();
}
