import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apis_and_networking/components/article_builder.dart';
import 'package:flutter_apis_and_networking/cubit/news_cubit.dart';
import 'package:flutter_apis_and_networking/cubit/news_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context,state){},
          builder: (context,state){
            final NewsCubit cubit = NewsCubit.get(context);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                      labelText: 'search',
                      focusedBorder: OutlineInputBorder( borderSide: BorderSide(color: Theme.of(context).accentColor)),
                    ),
                    style: TextStyle(color: Theme.of(context).accentColor),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    onChanged: (text){
                      if(!searchController.text.isEmpty) { cubit.getSearchArticles(searchController.text); }
                    },
                  ),
                ),
                searchController.text.isEmpty
                ? Expanded(child: Center(child: Text('Search Text Is Empty\n!!!',style: TextStyle(fontSize: 30,color: Theme.of(context).accentColor.withOpacity(0.7)),textAlign: TextAlign.center,),))
                : Expanded(child: ArticleBuilder(cubit.searchArticles))
              ],
            );
          },
        )
      ),
    );
  }
}
