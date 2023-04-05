import 'package:flutter/material.dart';
import 'package:wave_news/src/models/article_model.dart';
import 'package:wave_news/src/screen/web_view.dart';
import 'package:wave_news/src/services/api_services.dart';
import 'package:wave_news/src/utils/appbar.dart';

class ArticlePage extends StatelessWidget {
  final String category;
  final int index;
  ArticlePage({super.key, required this.index, required this.category});
  ApiServices client = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 35,
          ),
          const AppBarWidget(),
          const SizedBox(
            height: 16,
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
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              snapshot.data!.articles![index].urlToImage
                                  .toString(),
                            ),
                          ),
                        ),
                        height: 430,
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 230,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 8)
                                  ]),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                snapshot.data!.articles![index].title
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 29,
                                    fontWeight: FontWeight.bold),
                                maxLines: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        height: 340,
                        width: 397,
                        child: Container(
                          // alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(15),
                          height: 340,
                          width: 397,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(39),
                              topRight: Radius.circular(39),
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: 8,
                                  endIndent: 8,
                                  thickness: 3,
                                ),
                                Text(
                                  snapshot.data!.articles![index].description
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 22,
                                  ),
                                )
                              ]),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 130,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              (context),
                              MaterialPageRoute(
                                builder: (context) => ArticleWebView(
                                  url: snapshot.data!.articles![index].url
                                      .toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(8),
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: Color.fromARGB(255, 8, 136, 200),
                            ),
                            child: Center(
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.white,
      //   height: 60,
      //   alignment: Alignment.center,
      //   child:
      // ),
    );
  }
}
