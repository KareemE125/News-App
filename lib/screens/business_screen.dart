import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/components/article_builder.dart';
import 'package:flutter_apis_and_networking/cubit/news_cubit.dart';
import 'package:flutter_apis_and_networking/cubit/news_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        final NewsCubit cubit = NewsCubit.get(context);
        if(isInit){ isInit = false; cubit.getBusinessArticles();}

        return ArticleBuilder(cubit.businessArticles);
      },
    );
  }
}
