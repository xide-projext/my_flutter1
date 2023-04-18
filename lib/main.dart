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
              const Placeholder(
                fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text('Three-line ListTile'),
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.  $index'),
                      trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
              const Placeholder(
                fallbackHeight: 100, // Placeholder의 높이를 지정합니다.
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
