import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/cubit/news_states.dart';
import 'package:flutter_apis_and_networking/helpers/cache_helper.dart';
import 'package:flutter_apis_and_networking/helpers/networking/dio_helper.dart';
import 'package:flutter_apis_and_networking/screens/business_screen.dart';
import 'package:flutter_apis_and_networking/screens/science_screen.dart';
import 'package:flutter_apis_and_networking/screens/sports_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const APIKEY = 'f44b34d965b64a71ae886eaedc577fd3';

class NewsCubit extends Cubit<NewsStates>{

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  ThemeMode themeMode =
        (CacheHelper.sharedPreferences.getBool('isDark') ?? false) ? ThemeMode.dark : ThemeMode.light;
  int currentIndex = 0;
  List<Widget> bottomNavScreens = [ BusinessScreen(), SportsScreen(), ScienceScreen() ];
  List businessArticles = [];
  List sportsArticles = [];
  List scienceArticles = [];
  List searchArticles = [];


  void toggleThemeMode()
  {
    if( themeMode != ThemeMode.dark ){ themeMode = ThemeMode.dark; }
    else{ themeMode = ThemeMode.light; }

    bool isDark = CacheHelper.sharedPreferences.getBool('isDark')??false;
    CacheHelper.sharedPreferences.setBool('isDark', !isDark)
      .then((_){ emit(NewsThemeModeToggleState()); });
  }

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavBarState());
  }

  Future<void> getBusinessArticles() async
  {
    emit(NewsGetBusinessLoadingState());
    try
    {
      final Response response = await DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apikey': APIKEY,
        },
      );

      businessArticles = response.data['articles'];

      emit(NewsGetBusinessSuccessState());
    }
    catch(error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState());
    }

  }

  Future<void> getSportsArticles() async
  {
    emit(NewsGetSportsLoadingState());
    try
    {
      final Response response = await DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apikey': APIKEY,
          },
      );

      sportsArticles = response.data['articles'];

      emit(NewsGetSportsSuccessState());
    }
    catch(error)
    {
      print(error.toString());
      emit(NewsGetSportsErrorState());
    }

  }

  Future<void> getScienceArticles() async
  {
    emit(NewsGetScienceLoadingState());
    try
    {
      final Response response = await DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey': APIKEY,
        },
      );

      scienceArticles = response.data['articles'];

      emit(NewsGetScienceSuccessState());
    }
    catch(error)
    {
      print(error.toString());
      emit(NewsGetScienceErrorState());
    }

  }

  Future<void> getSearchArticles(String searchText) async
  {
    emit(NewsGetSearchLoadingState());
    try
    {
      final Response response = await DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q': searchText,
          'apikey': APIKEY,
        },
      );

      searchArticles = response.data['articles'];

      emit(NewsGetSearchSuccessState());
    }
    catch(error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState());
    }

  }

}