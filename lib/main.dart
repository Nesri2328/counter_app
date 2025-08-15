import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // For delayed animations
import 'dart:math'; // For random numbers

void main() {
  runApp(
    // Wrap the entire app with a ChangeNotifierProvider.
    // This makes the UserProvider instance available to all widgets below it.
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const QuizApp(),
    ),
  );
}

// UserProvider class manages the state of the current user.
// It extends ChangeNotifier to notify listeners when data changes.
class UserProvider with ChangeNotifier {
  String _username = '';
  int _score = 0;
  List<Map<String, dynamic>> _leaderboardData = [];

  String get username => _username;
  int get score => _score;
  List<Map<String, dynamic>> get leaderboardData => _leaderboardData;

  // Initializes the user data, simulating a login.
  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  // Updates the score after a quiz is completed.
  void updateScore(int newScore) {
    _score = newScore;
    notifyListeners();
  }

  // Simulates fetching leaderboard data and includes the current user's score.
  void updateLeaderboard() {
    _leaderboardData = [
      {'name': 'Alex', 'score': 120},
      {'name': 'Sarah', 'score': 110},
      {'name': 'Mike', 'score': 95},
      {'name': 'Jessica', 'score': 80},
    ];
    // Find if the current user is already on the list.
    final currentUserIndex = _leaderboardData.indexWhere(
      (user) => user['name'] == _username,
    );
    if (currentUserIndex != -1) {
      // Update their score if they are.
      _leaderboardData[currentUserIndex]['score'] = _score;
    } else {
      // Add the current user to the list if they are not.
      _leaderboardData.add({'name': _username, 'score': _score});
    }

    // Sort the list by score in descending order.
    _leaderboardData.sort((a, b) => (b['score']).compareTo(a['score']));

    notifyListeners();
  }
}

// Main application widget, handles the theme and initial screen.
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Quest',
      // The debugger banner has been removed.
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Use a popular, clean blue color scheme.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.lightBlue,
          tertiary: Colors.blueAccent,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
      home: const SignInScreen(),
    );
  }
}

// A simple sign-in screen with an animated hero icon.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.emoji_events,
                    size: 120,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quiz Quest',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white54),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final String username = usernameController.text.trim();
                    if (username.isNotEmpty) {
                      // Set the username in the provider
                      Provider.of<UserProvider>(
                        context,
                        listen: false,
                      ).setUsername(username);
                      // Navigate to the home screen.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Home screen with bottom navigation and a new drawer for navigation.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens for the bottom navigation bar and drawer.
  static final List<Widget> _widgetOptions = <Widget>[
    const WelcomeScreen(),
    const RewardsScreen(rewardType: 'none'),
    const LeaderboardScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${userProvider.username}!'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Quiz Quest',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Signed in as: ${userProvider.username}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Quiz'),
              selected: _selectedIndex == 0,
              onTap: () {
                _navigateToScreen(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Rewards'),
              selected: _selectedIndex == 1,
              onTap: () {
                _navigateToScreen(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: const Text('Leaderboard'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the leaderboard data before navigating.
                userProvider.updateLeaderboard();
                _navigateToScreen(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedIndex == 3,
              onTap: () {
                _navigateToScreen(3);
              },
            ),
          ],
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Rewards'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 2) {
            // Update the leaderboard data when navigating to the Leaderboard.
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateLeaderboard();
          }
          _onItemTapped(index);
        },
      ),
    );
  }
}

// This screen is where the main quiz logic resides. Now with a loading state.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;
  bool _isLoading = true;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'London', 'isCorrect': false},
        {'text': 'Paris', 'isCorrect': true},
        {'text': 'Berlin', 'isCorrect': false},
        {'text': 'Rome', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Who painted the Mona Lisa?',
      'answers': [
        {'text': 'Vincent van Gogh', 'isCorrect': false},
        {'text': 'Pablo Picasso', 'isCorrect': false},
        {'text': 'Leonardo da Vinci', 'isCorrect': true},
        {'text': 'Claude Monet', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'What is the largest planet in our solar system?',
      'answers': [
        {'text': 'Mars', 'isCorrect': false},
        {'text': 'Jupiter', 'isCorrect': true},
        {'text': 'Earth', 'isCorrect': false},
        {'text': 'Saturn', 'isCorrect': false},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  // Simulates fetching questions from a backend with a 2-second delay.
  Future<void> _fetchQuestions() async {
    // In a real app, this would be an API call
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    setState(() {
      _questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Quest'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _questionIndex < _questions.length
          ? Quiz(
              question: _questions[_questionIndex]['questionText'] as String,
              answers:
                  _questions[_questionIndex]['answers']
                      as List<Map<String, Object>>,
              answerQuestion: _answerQuestion,
            )
          : ResultScreen(score: _score, totalQuestions: _questions.length),
    );
  }
}

// Screen that displays the quiz questions and answer buttons. Now with more dynamic animations.
class Quiz extends StatefulWidget {
  final String question;
  final List<Map<String, Object>> answers;
  final Function(bool) answerQuestion;

  const Quiz({
    super.key,
    required this.question,
    required this.answers,
    required this.answerQuestion,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Create a staggered animation for each answer button.
    _animations = List.generate(widget.answers.length, (index) {
      final interval = Interval(
        index * (1 / widget.answers.length), // Start the next animation later
        1.0,
        curve: Curves.easeOut,
      );
      return Tween<Offset>(
        begin: const Offset(0, 1), // Start from below
        end: Offset.zero, // Move to its original position
      ).animate(CurvedAnimation(parent: _controller, curve: interval));
    });

    // Start the animation after a small delay to allow the screen to build.
    Timer(const Duration(milliseconds: 100), () {
      _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant Quiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart the animation whenever the question changes.
    if (oldWidget.question != widget.question) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Animate the question text.
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              widget.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Updated to match the new color scheme
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Loop through the answers and apply the staggered slide animation.
          ...List.generate(widget.answers.length, (index) {
            final answer = widget.answers[index];
            return SlideTransition(
              position: _animations[index],
              child: FadeTransition(
                opacity: _controller,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.reverse().then((_) {
                        widget.answerQuestion(answer['isCorrect'] as bool);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      answer['text'] as String,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Screen that shows the final quiz result.
class ResultScreen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final List<ConfettiParticle> _confettiParticles;
  final Random _random = Random();
  final int _numberOfParticles = 50;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // If the user gets a perfect score, start the confetti animation.
    if (widget.score == widget.totalQuestions) {
      _confettiParticles = List.generate(
        _numberOfParticles,
        (_) => ConfettiParticle(
          color: _randomColor(),
          x: _random.nextDouble() * 2 - 1,
          y: -1.0,
          velocity: Offset(
            _random.nextDouble() * 0.4 - 0.2,
            _random.nextDouble() * 0.4 + 0.1,
          ),
          size: _random.nextDouble() * 10 + 5,
        ),
      );
      _controller.forward();
    } else {
      _confettiParticles = [];
    }
  }

  // Generate a random color for the confetti.
  Color _randomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _getRewardType {
    if (widget.score == widget.totalQuestions) {
      return 'master';
    } else if (widget.score >= widget.totalQuestions / 2) {
      return 'good';
    } else {
      return 'beginner';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the score in the provider.
    Provider.of<UserProvider>(context, listen: false).updateScore(widget.score);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.celebration,
                    size: 100,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'You scored ${widget.score} out of ${widget.totalQuestions}!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the rewards screen with the result type.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RewardsScreen(rewardType: _getRewardType),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Claim Your Reward',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Confetti animation layer
          if (widget.score == widget.totalQuestions)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ConfettiPainter(
                    particles: _confettiParticles,
                    animationValue: _controller.value,
                  ),
                  child: Container(),
                );
              },
            ),
        ],
      ),
    );
  }
}

// A simple class to represent a single confetti particle.
class ConfettiParticle {
  final Color color;
  double x;
  double y;
  final Offset velocity;
  final double size;

  ConfettiParticle({
    required this.color,
    required this.x,
    required this.y,
    required this.velocity,
    required this.size,
  });
}

// Custom Painter to draw the confetti particles.
class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;
  final double animationValue;

  ConfettiPainter({required this.particles, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Loop through each particle and draw it.
    for (var particle in particles) {
      final x = size.width * (particle.x + 1) / 2;
      final y = size.height * (particle.y + 1) / 2;

      // Update particle position based on animation value and velocity.
      particle.y += particle.velocity.dy * (1 - animationValue) * 0.05;
      particle.x += particle.velocity.dx * (1 - animationValue) * 0.05;

      // Draw the particle with a fading effect.
      final paint = Paint()
        ..color = particle.color.withOpacity(1 - animationValue)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x, y),
        particle.size * (1 - animationValue),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint to show the animation.
  }
}

// A dedicated screen to show a reward based on performance.
class RewardsScreen extends StatelessWidget {
  final String rewardType;

  const RewardsScreen({super.key, required this.rewardType});

  Map<String, dynamic> get _getRewardDetails {
    switch (rewardType) {
      case 'master':
        return {
          'message': 'You are a Quiz Master!',
          'icon': Icons.diamond,
          'color': Colors.blue,
        };
      case 'good':
        return {
          'message': 'You earned a silver medal!',
          'icon': Icons.star,
          'color': Colors.grey,
        };
      case 'beginner':
        return {
          'message': 'Keep practicing to get your reward!',
          'icon': Icons.emoji_emotions,
          'color': Colors.orange,
        };
      default:
        return {
          'message': 'Start a quiz to earn a reward!',
          'icon': Icons.quiz,
          'color': Colors.blue,
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final details = _getRewardDetails;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(details['icon'], size: 100, color: details['color']),
              const SizedBox(height: 20),
              Text(
                details['message'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // This button now correctly navigates back to the HomeScreen,
                  // ensuring the bottom navigation bar is visible.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Play Again',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Functional Leaderboard screen with Provider.
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to get the leaderboard data.
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: userProvider.leaderboardData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: userProvider.leaderboardData.length,
                itemBuilder: (context, index) {
                  final entry = userProvider.leaderboardData[index];
                  final isCurrentUser = entry['name'] == userProvider.username;
                  return Card(
                    color: isCurrentUser
                        ? Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.2)
                        : null,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isCurrentUser
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                      title: Text(
                        entry['name'],
                        style: TextStyle(
                          fontWeight: isCurrentUser
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 18,
                          color: isCurrentUser
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                      trailing: Text(
                        'Score: ${entry['score']}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isCurrentUser
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

// Functional Settings screen with Provider.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current username from the provider.
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _usernameController = TextEditingController(text: userProvider.username);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _saveUsername() {
    final newUsername = _usernameController.text.trim();
    if (newUsername.isNotEmpty) {
      // Update the username in the provider.
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).setUsername(newUsername);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'User Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveUsername,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

// Welcome Screen, now part of the main navigation flow.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Icon(
                  Icons.emoji_events,
                  size: 100,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Welcome to Quiz Quest!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Test your knowledge and earn rewards.',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
