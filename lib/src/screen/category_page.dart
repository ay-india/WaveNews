import 'package:flutter/material.dart';
import 'package:wave_news/src/models/article_model.dart';
import 'package:wave_news/src/screen/article_page.dart';
import 'package:wave_news/src/services/api_services.dart';

import '../utils/appbar.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState(category: category);
}

class _CategoryPageState extends State<CategoryPage> {
  final String category;
  _CategoryPageState({required this.category});
  ApiServices client = ApiServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 35,
      ),
      const AppBarWidget(),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            category.isEmpty
                ? 'Trending News'
                : category.toUpperCase() + ' News',
            style: TextStyle(
                fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
          child: FutureBuilder(
        future: category.isEmpty
            ? client.fetchTreandingArticleRecords()
            : client.fetchAllArticleRecords(category),
        builder: (context, AsyncSnapshot<ArticleModel> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  // scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.totalResults,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(
                              index: index,
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(12),
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(
                                0.5,
                              ),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(
                                0,
                                3,
                              ),
                            ),
                          ],
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(snapshot
                                        .data!.articles![index].urlToImage
                                        .toString()))),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 15,
                                  right: 8,
                                  left: 8,
                                  bottom: 8,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 50,
                                width: 230,
                                decoration: BoxDecoration(
                                  // color: Colors.white38,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(3),
                                // margin: EdgeInsets.all(5),
                                alignment: Alignment.bottomRight,
                                height: 25,
                                width: 230,
                                // color: Colors.white54,
                                child: Text(
                                  snapshot.data!.articles![index].source!.name
                                      .toString(),
                                ),
                              ),
                            ],
                          )
                        ]),
                      ),
                    );
                    // return Container(
                    //   height: 50,
                    //   width: 100,
                    //   margin: EdgeInsets.all(10),
                    //   child: Text(snapshot
                    //       .data!.articles![index].source!.name
                    //       .toString()),
                    // );
                  }),
            );
          }
        },
      ))
    ]));
  }
}
