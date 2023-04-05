import 'package:flutter/material.dart';
import 'package:wave_news/src/utils/appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String url;
  ArticleWebView({super.key, required this.url});

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState(url: url);
}

class _ArticleWebViewState extends State<ArticleWebView> {
  final String url;
  var isLoading = true;
  _ArticleWebViewState({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: 35,
        ),
        const AppBarWidget(),
        Expanded(
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Stack(),
            ],
          ),
        ),
      ]),
    );
  }
}
