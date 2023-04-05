import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wave_news/src/screen/article_page.dart';
import 'package:wave_news/src/screen/category_page.dart';
import 'package:wave_news/src/services/api_services.dart';
import 'package:wave_news/src/utils/appbar.dart';

import '../models/article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _categoryList = [
    'All',
    'Technology',
    'Sports',
    'Entertainment',
    'India'
  ];
  ApiServices client = ApiServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 35,
          ),
          const AppBarWidget(),

          // Search Bar

          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
          //   // padding: EdgeInsets.all(8),
          //   height: 50,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(30.0),
          //     color: Colors.grey[300],
          //   ),
          //   child: TextField(
          //     controller: searchController,
          //     onChanged: (value) {
          //       setState(() {});
          //     },
          //     decoration: InputDecoration(
          //       contentPadding: EdgeInsets.symmetric(
          //         horizontal: 19,
          //       ),
          //       hintText: "Search your favourite news",
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //     ),
          //   ),
          // ),

//--------------------------------------------------------------
          ///category page

          // ListView.builder(itemCount: _categoryList.length,
          //   itemBuilder: (context,index){
          //     return Container();

          // },),

//--------------------------------------------------------------
          // Trending News

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Treading News",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(category: ''),
                      ),
                    );
                  },
                  child: Text(
                    "See More",
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            child: FutureBuilder(
              future: client.fetchTreandingArticleRecords(),
              builder: (context, AsyncSnapshot<ArticleModel> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.totalResults,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticlePage(
                                          index: index,
                                          category: "",
                                        )));
                          },
                          child: Container(
                            margin: EdgeInsets.all(12),
                            // height: 200,
                            width: 250,

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
                            child: Column(children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                height: 130,
                                width: 230,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(18),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(snapshot
                                            .data!.articles![index].urlToImage
                                            .toString()))),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3),
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
                      });
                }
              },
            ),
          ),

          SizedBox(
            height: 15,
          ),
//----------------------------------------------------------------------
          // Popular News

          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Popular News",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      (context),
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(category: 'popular'),
                      ),
                    );
                  },
                  child: Text(
                    "See More",
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                child: FutureBuilder(
                  future: client.fetchAllArticleRecords("popular"),
                  builder: (context, AsyncSnapshot<ArticleModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      ;
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
                                        category: "popular",
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
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapshot.data!
                                                  .articles![index].urlToImage
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 50,
                                          width: 230,
                                          decoration: BoxDecoration(
                                            // color: Colors.white38,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
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
                                            snapshot.data!.articles![index]
                                                .source!.name
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
                )),
          )
        ],
      ),
    );
  }
}
