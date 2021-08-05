import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/components/list_card.dart';

class ArticleBuilder extends StatelessWidget {
  final List list;

  ArticleBuilder(this.list);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ?  Center(child: CircularProgressIndicator(),)
        : ListView.builder(
      itemCount: list.length,
      itemBuilder: (context,index) => ListCard(article: list[index]),
      physics: BouncingScrollPhysics(),
    );
  }
}
