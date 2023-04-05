import "package:flutter/material.dart";

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: double.infinity,
      // color: Colors.yellow,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
        Text(
          "WAVE",
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          "News",
          style: TextStyle(
            fontSize: 33,
            // fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
