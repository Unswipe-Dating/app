import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:unswipe/main.dart';
import 'package:unswipe/src/core/app_error.dart';
import 'package:unswipe/src/core/utils/constant/on_boarding_token_entity.dart';
import 'package:unswipe/src/core/utils/streams.dart';
import 'package:unswipe/src/shared/domain/entities/onbaording_state/onboarding_state.dart';
import 'package:unswipe/src/shared/domain/repository/on_boarding_repository.dart';
import '../../../../data/exception/local_data_source_exception.dart';
import '../../../../data/exception/remote_data_source_exception.dart';
import '../../../core/cancellation_exception.dart';
import '../../../core/local_data_source.dart';


class OnBoardingRepositoryImpl implements OnBoardingRepository {
  final LocalDataSource _localDataSource;



}
