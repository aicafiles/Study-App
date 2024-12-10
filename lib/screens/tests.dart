import 'package:flutter/material.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  final List<Map<String, dynamic>> _customTests = [];

  void _navigateToCreateTest() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateTestScreen(
          onSave: (test) {
            setState(() {
              _customTests.add(test);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Practice Tests',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Manage or take your tests below',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            _buildActionButton(
              icon: Icons.add_circle_outline,
              label: "Create New Test",
              color: Colors.teal[400]!,
              onPressed: _navigateToCreateTest,
            ),
            const SizedBox(height: 30),
            const Text(
              "Your Custom Tests",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1),
            Expanded(
              child: _customTests.isNotEmpty
                  ? ListView.builder(
                itemCount: _customTests.length,
                itemBuilder: (context, index) {
                  final test = _customTests[index];
                  return _buildTestCard(test, index);
                },
              )
                  : const Center(
                child: Text(
                  "No custom tests created yet.",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF757575),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(Map<String, dynamic> test, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TakeCustomTestScreen(test: test),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[200 + (index % 2) * 100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              test['name'],
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${test['questions'].length} Questions",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTestScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  const CreateTestScreen({super.key, required this.onSave});

  @override
  State<CreateTestScreen> createState() => _CreateTestScreenState();
}

class _CreateTestScreenState extends State<CreateTestScreen> {
  final _testNameController = TextEditingController();
  final List<Map<String, dynamic>> _questions = [];

  final _questionController = TextEditingController();
  final _answerController = TextEditingController();
  final List<TextEditingController> _optionControllers = [];
  String _questionType = 'Identification';

  void _addQuestion() {
    if (_questionController.text.isNotEmpty &&
        (_questionType == 'Identification' && _answerController.text.isNotEmpty ||
            _questionType == 'Multiple Choice' &&
                _optionControllers.any((controller) => controller.text.isNotEmpty))) {
      setState(() {
        final question = {
          'type': _questionType,
          'question': _questionController.text,
          'options': _questionType == 'Multiple Choice'
              ? _optionControllers.map((controller) => controller.text).toList()
              : [],
          'answer': _answerController.text,
        };
        _questions.add(question);
        _questionController.clear();
        _answerController.clear();
        _optionControllers.clear();
      });
    }
  }

  void _saveTest() {
    if (_testNameController.text.isNotEmpty && _questions.isNotEmpty) {
      widget.onSave({
        'name': _testNameController.text,
        'questions': _questions,
      });
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide a test name and at least one question.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Create Test",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInputField(
              controller: _testNameController,
              label: 'Test Name',
              hintText: 'Enter the name of the test',
            ),
            const SizedBox(height: 16),

            _buildInputField(
              controller: _questionController,
              label: 'Question',
              hintText: 'Enter your question here',
            ),
            const SizedBox(height: 16),

            _buildDropdown(
              value: _questionType,
              items: const [
                DropdownMenuItem(
                  value: 'Identification',
                  child: Text('Identification'),
                ),
                DropdownMenuItem(
                  value: 'Multiple Choice',
                  child: Text('Multiple Choice'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _questionType = value!;
                  _optionControllers.clear();
                });
              },
              label: 'Question Type',
            ),
            const SizedBox(height: 16),

            if (_questionType == 'Multiple Choice') ...[
              for (int i = 0; i < 4; i++) ...[
                _buildInputField(
                  controller: i < _optionControllers.length
                      ? _optionControllers[i]
                      : (_optionControllers..add(TextEditingController())).last,
                  label: 'Option ${i + 1}',
                  hintText: 'Enter option ${i + 1}',
                ),
                const SizedBox(height: 8),
              ]
            ],

            _buildInputField(
              controller: _answerController,
              label: 'Correct Answer',
              hintText: 'Enter the correct answer',
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: _addQuestion,
              icon: const Icon(Icons.add),
              label: const Text("Add Question"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 24),

            if (_questions.isNotEmpty) ...[
              const Text(
                'Questions Added:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ..._questions.map((q) => Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(
                    q['question'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    q['type'],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )),
            ],
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _saveTest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Save Test"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
    required String label,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
class TakeCustomTestScreen extends StatefulWidget {
  final Map<String, dynamic> test;

  const TakeCustomTestScreen({super.key, required this.test});

  @override
  State<TakeCustomTestScreen> createState() => _TakeCustomTestScreenState();
}

class _TakeCustomTestScreenState extends State<TakeCustomTestScreen> {
  int _currentQuestionIndex = 0;
  final List<String?> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _userAnswers.addAll(List.filled(widget.test['questions'].length, null));
  }

  void _submitAnswer() {
    setState(() {
      if (_currentQuestionIndex < widget.test['questions'].length - 1) {
        _currentQuestionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.test['questions'].length; i++) {
      if (_userAnswers[i] == widget.test['questions'][i]['answer']) {
        correctAnswers++;
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Test Completed",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "You scored $correctAnswers out of ${widget.test['questions'].length}.",
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(fontFamily: 'Poppins', color: Colors.teal),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.test['questions'][_currentQuestionIndex];
    final isMultipleChoice = question['type'] == 'Multiple Choice';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.test['name'],
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Question ${_currentQuestionIndex + 1}/${widget.test['questions'].length}",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question['question'],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (isMultipleChoice)
              ...question['options']
                  .map<Widget>(
                    (option) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: RadioListTile<String>(
                    value: option,
                    groupValue: _userAnswers[_currentQuestionIndex],
                    onChanged: (value) {
                      setState(() {
                        _userAnswers[_currentQuestionIndex] = value;
                      });
                    },
                    title: Text(
                      option,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ),
              )
                  .toList()
            else
              TextField(
                onChanged: (value) {
                  _userAnswers[_currentQuestionIndex] = value;
                },
                decoration: InputDecoration(
                  labelText: 'Your Answer',
                  labelStyle: const TextStyle(fontFamily: 'Poppins'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                _currentQuestionIndex < widget.test['questions'].length - 1
                    ? "Next Question"
                    : "Finish Test",
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}