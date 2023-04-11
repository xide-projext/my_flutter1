import 'dart:convert';
import 'package:flutter/material.dart';

final toons = [
  {"title": "이상한 변호사 우영우", "image": "https://my-k-toon.web.app/webtoon/1.png"},
  {"title": "외모지상주의", "image": "https://my-k-toon.web.app/webtoon/2.png"}
];

// Router
void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => const FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => const FirstScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("내폰내툰")),
        body: Center(
            child: Container(
                margin: const EdgeInsets.all(10.0),
                color: Colors.amber[600],
                child: Column(children: [
                  const Placeholder(fallbackHeight: 40),
                  Row(
                      children: toons
                          .map<Widget>(
                            (item) => Column(children: [
                              Image.network(item['image']!),
                              Text(item['title']!)
                            ]),
                          )
                          .toList()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      Icon(
                        Icons.audiotrack,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Icon(
                        Icons.beach_access,
                        color: Colors.blue,
                        size: 36.0,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            Navigator.pushNamed(context, '/second');
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ]))));
  }
}
