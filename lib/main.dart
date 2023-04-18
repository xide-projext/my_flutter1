import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => QuizPage(),
      '/result': (context) => ThirdScreen(),
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

// https://sharegpt.com/c/B3lxchS
class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _correctAnswers = 0;
  int _wrongAnswers = 0;
  int _currentIndex = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'apple',
      'answers': ['사과', '포도', '배'],
      'correctIndex': 0,
    },
    {
      'question': 'banana',
      'answers': ['바나나', '키위', '딸기'],
      'correctIndex': 0,
    },
    {
      'question': 'cherry',
      'answers': ['체리', '수박', '포도'],
      'correctIndex': 0,
    },
  ];

  void _onAnswerSelected(int selectedIndex) {
    setState(() {
      if (_questions[_currentIndex]['correctIndex'] == selectedIndex) {
        _correctAnswers++;
      } else {
        _wrongAnswers++;
      }

      if (_currentIndex == _questions.length - 1) {
        Navigator.pushNamed(
          context,
          '/result',
          arguments: {
            'correctAnswers': _correctAnswers,
            'totalQuestions': _questions.length
          },
        );
      } else {
        _currentIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('퀴즈'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '문제 ${_currentIndex + 1}/${_questions.length}',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      _questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 28),
                    ),
                    ...(_questions[_currentIndex]['answers'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => ElevatedButton(
                            onPressed: () => _onAnswerSelected(entry.key),
                            child: Text(
                              entry.value,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
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
