import 'package:flutter/material.dart';
import 'models.dart';
import 'data.dart';

void main() {
  runApp(const App());
}

// ---------------- ADMINS ----------------
const Map<String, String> admins = {
  "Hossein_1997": "1234567",
  "AmirAli_1997": "1234567",
};

// ---------------- APP ----------------
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mathverse School PRO',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

// ---------------- LOGIN ----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();

  void login() {
    if (admins[user.text.trim()] == pass.text.trim()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminPanel()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StudentHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: user, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: pass, decoration: const InputDecoration(labelText: "Password")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Login")),
          ],
        ),
      ),
    );
  }
}

// ---------------- STUDENT HOME ----------------
class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int score = 0;

  void addScore() {
    setState(() {
      score += 10;
      students[0].score = score;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student 🎓")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Your Score: $score ⭐"),
            trailing: ElevatedButton(
              onPressed: addScore,
              child: const Text("+10"),
            ),
          ),
          ListTile(
            title: const Text("🏆 Leaderboard"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const Leaderboard()));
            },
          ),
          ListTile(
            title: const Text("👤 Profile"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
          ),
          ListTile(
            title: const Text("📚 Assignments"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AssignmentPage()));
            },
          ),
          ListTile(
            title: const Text("💬 Feedback"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const FeedbackPage()));
            },
          ),
        ],
      ),
    );
  }
}

// ---------------- PROFILE ----------------
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Score: ${students[0].score} ⭐",
            style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}

// ---------------- LEADERBOARD ----------------
class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    students.sort((a, b) => b.score.compareTo(a.score));

    return Scaffold(
      appBar: AppBar(title: const Text("Leaderboard 🏆")),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Text("🥇"),
            title: Text(students[i].name),
            trailing: Text("${students[i].score} ⭐"),
          );
        },
      ),
    );
  }
}

// ---------------- ASSIGNMENTS ----------------
class AssignmentPage extends StatelessWidget {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Assignments 📚")),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(assignments[i]),
          );
        },
      ),
    );
  }
}

// ---------------- FEEDBACK ----------------
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Feedback 💬")),
      body: Column(
        children: [
          TextField(controller: c),
          ElevatedButton(
            onPressed: () {
              setState(() {
                feedbacks.add(c.text);
                c.clear();
              });
            },
            child: const Text("Send"),
          ),
          Expanded(
            child: ListView(
              children: feedbacks
                  .map((e) => ListTile(title: Text(e)))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

// ---------------- ADMIN ----------------
class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin 👑")),
      body: ListView(
        children: [
          const ListTile(title: Text("📊 Manage Students")),
          const ListTile(title: Text("📚 Manage Assignments")),
          const ListTile(title: Text("💬 View Feedback")),
        ],
      ),
    );
  }
}
