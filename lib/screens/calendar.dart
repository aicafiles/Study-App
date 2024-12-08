import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Map<String, String>>> _tasks = {};

  void _resetSelectedDate() {
    setState(() {
      _selectedDay = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _resetSelectedDate(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text(
            'All Assignments',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _showAllTasksDialog,
              icon: const Icon(Icons.view_list, color: Colors.black),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshTasks,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _resetSelectedDate,
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  eventLoader: (day) {
                    if (_tasks.containsKey(day) && _tasks[day]!.isNotEmpty) {
                      return ['task'];
                    }
                    return [];
                  },
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Color(0xFF42A5F5),
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Color(0xFFDEE7F2),
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                      color: const Color(0xFF66BB6A),
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                    defaultTextStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    outsideTextStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
                    titleTextStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _selectedDay == null ||
                      (_tasks[_selectedDay]?.isEmpty ?? true)
                      ? const Center(
                    child: Text(
                      'No tasks for this day',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : ListView.builder(
                    itemCount: _tasks[_selectedDay]!.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[_selectedDay]![index];
                      final title = task['title']!;
                      final notes = task['notes'] ?? '';
                      final daysLeft = _calculateDaysLeft(_selectedDay!);

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF66BB6A),
                            child: const Icon(Icons.book, color: Colors.white),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '($daysLeft days left)',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          subtitle: notes.isNotEmpty
                              ? Text(
                            notes,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )
                              : null,
                          onTap: () => _showTaskDetailsDialog(task, index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: _selectedDay != null
            ? FloatingActionButton(
          backgroundColor: const Color(0xFF42A5F5),
          onPressed: () => _addTaskDialog(context),
          child: const Icon(Icons.add, color: Colors.white),
        )
            : null,
      ),
    );
  }

  Future<void> _refreshTasks() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
    });
  }

  int _calculateDaysLeft(DateTime date) {
    final now = DateTime.now();
    return date.difference(now).inDays;
  }

  void _showTaskDetailsDialog(Map<String, String> task, int index) {
    final TextEditingController titleController =
    TextEditingController(text: task['title']);
    final TextEditingController notesController =
    TextEditingController(text: task['notes']);
    bool isEditable = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: titleController,
                      enabled: isEditable,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Task Title',
                        border: isEditable
                            ? const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xFF42A5F5), width: 2),
                        )
                            : InputBorder.none,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditable ? Icons.check : Icons.edit,
                      color: const Color(0xFF42A5F5),
                    ),
                    onPressed: () {
                      setState(() {
                        if (isEditable) {
                          setState(() {
                            _tasks[_selectedDay!]![index] = {
                              'title': titleController.text,
                              'notes': notesController.text,
                            };
                          });
                        }
                        isEditable = !isEditable;
                      });
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: notesController,
                      enabled: isEditable,
                      style: const TextStyle(
                        fontFamily: 'Poppins',


                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Notes',
                        border: isEditable
                            ? const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
                        )
                            : InputBorder.none,
                        focusedBorder: isEditable
                            ? const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2),
                        )
                            : InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _deleteTask(index);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addTaskDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Add New Task',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Task Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 19),
                TextField(
                  controller: notesController,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Notes',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final task = {
                      'title': titleController.text,
                      'notes': notesController.text,
                    };

                    setState(() {
                      if (_tasks[_selectedDay] == null) {
                        _tasks[_selectedDay!] = [];
                      }
                      _tasks[_selectedDay!]!.add(task);
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF42A5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Save Task',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showAllTasksDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'All Tasks',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _tasks.entries.map((entry) {
                  String formattedDate = _formatDate(entry.key);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF42A5F5),
                        ),
                      ),
                      ...entry.value.map((task) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: const Color(0xFF66BB6A),
                              child: const Icon(Icons.book, color: Colors.white),
                            ),
                            title: Text(
                              task['title'] ?? 'No title',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: task['notes'] != null
                                ? Text(
                              task['notes'] ?? 'No notes',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            )
                                : null,
                          ),
                        );
                      }),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd yyyy').format(date);
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks[_selectedDay]!.removeAt(index);
    });
  }
}

