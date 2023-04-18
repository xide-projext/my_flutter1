import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => SecondScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Language learning app")),
        body: Container(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Placeholder(
                fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(' ListTile $index'),
                  );
                },
              ),
              Placeholder(
                fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
              ),
            ],
          ),
        )));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("내폰내툰2")), body: const Text("2"));
  }
}
