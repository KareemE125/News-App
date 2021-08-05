import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/cubit/news_cubit.dart';
import 'package:flutter_apis_and_networking/cubit/news_states.dart';
import 'package:flutter_apis_and_networking/helpers/cache_helper.dart';
import 'package:flutter_apis_and_networking/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Apis & Networking'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){ Navigator.of(context).push(MaterialPageRoute(builder:(_)=>SearchScreen())); },
                ),
                IconButton(
                  icon: Icon(Icons.model_training),
                  onPressed: cubit.toggleThemeMode,
                )
              ],
            ),
            body: cubit.bottomNavScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.business_center,), label: 'Business'),
                BottomNavigationBarItem(icon: Icon(Icons.sports_basketball_rounded), label: 'Sports'),
                BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
              ],
              onTap: (index){ cubit.changeIndex(index); },
            ),
          );
        },
    );
  }
}
