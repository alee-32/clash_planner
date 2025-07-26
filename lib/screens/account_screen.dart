import 'package:flutter/material.dart';
import '../models/account.dart';

class AccountScreen extends StatefulWidget {
  final Account account;

  AccountScreen({required this.account});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        String taskTitle = '';
        return AlertDialog(
          title: Text('Nuova attività'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Scrivi attività'),
            onChanged: (val) => taskTitle = val,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Annulla')),
            TextButton(
              child: Text('Aggiungi'),
              onPressed: () {
                if (taskTitle.trim().isNotEmpty) {
                  setState(() {
                    widget.account.tasks.add(Task(title: taskTitle));
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _setBuilderFreeTime() {
    final now = DateTime.now();
    final time = TimeOfDay.now();
    showTimePicker(
      context: context,
      initialTime: time,
    ).then((selected) {
      if (selected != null) {
        final dt = DateTime(now.year, now.month, now.day, selected.hour, selected.minute);
        setState(() {
          widget.account.builderFreeAt = dt.isBefore(now) ? dt.add(Duration(days: 1)) : dt;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.account.name)),
      body: Column(
        children: [
          ListTile(
            title: Text('Costruttore libero alle:'),
            subtitle: Text(widget.account.builderFreeAt != null
                ? '${widget.account.builderFreeAt!.hour.toString().padLeft(2, '0')}:${widget.account.builderFreeAt!.minute.toString().padLeft(2, '0')}'
                : 'non impostato'),
            trailing: Icon(Icons.schedule),
            onTap: _setBuilderFreeTime,
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.account.tasks.length,
              itemBuilder: (_, i) {
                final task = widget.account.tasks[i];
                return CheckboxListTile(
                  value: task.done,
                  title: Text(task.title),
                  onChanged: (val) {
                    setState(() {
                      task.done = val ?? false;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }
}
