import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => QuizPage(),
      '/third': (context) => ThirdScreen(),
    },
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Language learning app")),
        body: SingleChildScrollView(
            // https://api.flutter.dev/flutter/widgets/SingleChildScrollView-class.html
            child: Column(children: [
          const Placeholder(
            fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
          ),
          SizedBox(
              height: 300, //
              child: SingleChildScrollView(
                  // https://sharegpt.com/c/Se6pTmq
                  child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 17,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    // https://api.flutter.dev/flutter/material/ListTile-class.html
                    child: ListTile(
                      leading: FlutterLogo(size: 72.0),
                      title: Text('Three-line ListTile'),
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.  $index'),
                      trailing: Icon(Icons.more_vert),
                      isThreeLine: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/second');
                      }, // Handle your onTap here.
                    ),
                  );
                },
              ))),
          const Placeholder(
            fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
          ),
        ])));
  }
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Column(
                children: [
                  Text('영어 단어'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('뜻 1'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('뜻 2'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('뜻 3'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text('맞은 개수: 0'),
            SizedBox(height: 8),
            Text('틀린 개수: 0'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/result');
              },
              child: Text('완료'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Language learning app")),
        body: const Text("3"));
  }
}
