import 'package:flutter/material.dart';

openUrl(BuildContext context, String url) {
  print(url);
  return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: Text("123"),
      ),
      body: Text("123"),
    );
  }));
}
