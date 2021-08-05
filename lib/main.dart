import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/cubit/news_states.dart';
import 'package:flutter_apis_and_networking/helpers/cache_helper.dart';
import 'package:flutter_apis_and_networking/helpers/networking/dio_helper.dart';
import 'package:flutter_apis_and_networking/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_apis_and_networking/cubit/news_cubit.dart';

import 'cubit/bloc_observer.dart';

void main() async
{
  // ensures that all methods are done before executing runApp(..) method
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.green[900],
              accentColor: Colors.black,
              colorScheme: ColorScheme.light().copyWith( primary: Colors.black,),
              textTheme: TextTheme(
                  bodyText2: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                selectedItemColor: Colors.green[700],
                selectedIconTheme: IconThemeData(size: 30),
                unselectedIconTheme: IconThemeData(size: 25),
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              accentColor: Colors.white,
              colorScheme: ColorScheme.dark().copyWith( primary: Colors.white,),
              textTheme: TextTheme(
                  bodyText2: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900)),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20,
                selectedItemColor: Colors.white,
                selectedIconTheme: IconThemeData(size: 30),
                unselectedIconTheme: IconThemeData(size: 25),
              ),
            ),
            themeMode: cubit.themeMode,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
