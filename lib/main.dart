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

/// 결과 페이지
/// * [correctAnswers] 정답 개수
/// * [totalQuestions] 총 문제 개수
///
/// 위 코드는 스크롤이 가능한 Column 위젯과, 그 안에 높이가 200인 빈 박스, 높이가 300인 스크롤 가능한 ListView.builder 위젯, 또 다시 높이가 200인 빈 박스로 구성되어 있습니다. 상단에는 앱바가 있으며, 두 번째 빈 박스 위에는 여러 개의 Card 위젯이 ListView.builder를 이용하여 리스트 형태로 출력됩니다. 리스트의 각 아이템은 ListTile 위젯으로 구성되며, FlutterLogo 위젯, Text 위젯, Icon 위젯으로 이루어져 있습니다. 리스트의 아이템을 탭하면 /second 경로로 이동합니다. 이렇게 스크롤이 가능한 Column 위젯과 ListView.builder

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final List<String> _items = List.generate(17, (index) => '$index');

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/second');
    } else {
      _showSnackbar(context, 'Please enter a valid email address');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Language learning app")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 2)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 120,
                      child: Card(
                        child: ListTile(
                          leading: FlutterLogo(size: 72.0),
                          title: Text('Three-line ListTile'),
                          subtitle: Text(
                              'A sufficiently long subtitle warrants three lines.  ${_items[index]}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _items.removeAt(index);
                              });
                              _showSnackbar(context, 'Item deleted');
                            },
                          ),
                          isThreeLine: true,
                          onTap: () {
                            Navigator.pushNamed(context, '/second');
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please enter your email address to continue:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _onSubmit,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
