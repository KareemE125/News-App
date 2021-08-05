import 'package:flutter/material.dart';
import 'package:flutter_apis_and_networking/screens/web_screen.dart';

class ListCard extends StatelessWidget {

  final article;

  ListCard({this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(5),
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(_)=>WebScreen(article['url'])));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 160,
          child: Row(
            children: [
              Container(
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: article['urlToImage'] != null? NetworkImage(article['urlToImage'].toString()) : NetworkImage('https://gfsstore.com/wp-content/themes/gfsstore.com/images/no_image_available.png'),
                      fit: BoxFit.cover,
                      onError: (o,s) => NetworkImage('https://www.pikpng.com/pngl/m/159-1594016_png-file-svg-error-icon-png-clipart.png'),
                    )
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article['title'].toString(),
                          textAlign: TextAlign.right,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          article['publishedAt'].toString(),
                          style: TextStyle(fontSize: 14,color: Colors.grey[500]),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
