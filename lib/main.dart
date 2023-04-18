import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => FirstScreen(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/second': (context) => QuizPage(),
    },
    onGenerateRoute: (RouteSettings settings) {
      // https://sharegpt.com/c/aPDwZ64
      if (settings.name == '/result') {
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ResultPage(
            correctAnswers: arguments['correctAnswers'] as int,
            totalQuestions: arguments['totalQuestions'] as int,
          ),
        );
      }
    },
  ));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Language learning app")), // 상단 앱바
        body: SingleChildScrollView(
            // 스크롤이 가능한 위젯
            child: Column(children: [
          const Placeholder(
            fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
          ), // 높이가 200인 빈 박스
          SizedBox(
              height: 300, //
              child: SingleChildScrollView(
                  // 스크롤이 가능한 위젯
                  child: ListView.builder(
                shrinkWrap: true, // 리스트뷰의 크기를 자식 위젯에 맞춥니다.
                physics:
                    const NeverScrollableScrollPhysics(), // 리스트뷰에서 스크롤 동작을 막습니다.
                itemCount: 17, // 아이템의 개수
                itemBuilder: (BuildContext context, int index) {
                  // 리스트뷰의 아이템을 구성하는 위젯
                  return Card(
                    // 카드 위젯
                    child: ListTile(
                      // 리스트 타일 위젯
                      leading:
                          FlutterLogo(size: 72.0), // 카드의 왼쪽에 이미지 아이콘을 표시합니다.
                      title: Text('Three-line ListTile'), // 리스트 타일의 제목
                      subtitle: Text(
                          'A sufficiently long subtitle warrants three lines.  $index'), // 리스트 타일의 부제목
                      trailing:
                          Icon(Icons.more_vert), // 리스트 타일의 오른쪽에 표시되는 추가 정보 아이콘
                      isThreeLine: true, // 리스트 타일이 세 줄로 구성됩니다.
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/second'); // 리스트 타일을 탭하면 /second 경로로 이동합니다.
                      }, // Handle your onTap here.
                    ),
                  );
                },
              ))),
          const Placeholder(
            fallbackHeight: 200, // Placeholder의 높이를 지정합니다.
          ), // 높이가 200인 빈 박스
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

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'apple',
      "answers": ['사과', '포도', '배'],
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

// https://sharegpt.com/c/aPDwZ64
class ResultPage extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;

  ResultPage({required this.correctAnswers, required this.totalQuestions});

  String get resultPhrase {
    double percentage = correctAnswers / totalQuestions;

    if (percentage >= 0.9) {
      return '대단해요!';
    } else if (percentage >= 0.7) {
      return '잘했어요!';
    } else if (percentage >= 0.5) {
      return '좀 더 노력해주세요';
    } else {
      return '분발하세요!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결과'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              resultPhrase,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              '맞은 개수: $correctAnswers/$totalQuestions',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: Text('홈으로'),
            ),
          ],
        ),
      ),
    );
  }
}
