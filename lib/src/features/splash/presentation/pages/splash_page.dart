
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:unswipe/src/features/splash/presentation/bloc/splash_bloc.dart';

import '../../../../../widgets/utils.dart';
import '../../../../core/helper/helper.dart';
import '../../../../core/utils/injections.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<SplashBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.orange,
        child: BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.loaded) {
          context.goNamed("login");
        }
      },
      child: Center(
        // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Image.asset(
            Helper.getImagePath("logo.png"),
            color: Helper.isDarkTheme() ? AppColors.white : null,
            width: 300.w,
            height: 300.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
      ),
      ),
    );
  }
}