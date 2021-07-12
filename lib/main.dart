import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_in/cubit/cubit.dart';
import 'package:shop_in/layout/home_layout.dart';
import 'package:shop_in/login/login_screen.dart';
import 'package:shop_in/on_boarding/on_boarding_screen.dart';
import 'package:shop_in/shared/bloc_observer.dart';
import 'package:shop_in/shared/components/constants.dart';
import 'package:shop_in/shared/network/local/cache_helper.dart';
import 'package:shop_in/shared/network/remote/dio_helper.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategories()
              ..getFavorites()
              ..getUesrData(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto',
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: startWidget,
        ));
  }
}
