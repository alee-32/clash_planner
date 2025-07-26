import 'package:flutter/material.dart';
import '../models/account.dart';
import 'account_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Account> accounts = [];

  void _addAccount() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = '';
        return AlertDialog(
          title: Text('Nuovo account'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Nome account'),
            onChanged: (val) => newName = val,
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Aggiungi'),
              onPressed: () {
                if (newName.trim().isNotEmpty) {
                  setState(() {
                    accounts.add(Account(name: newName, tasks: []));
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

  void _openAccount(Account acc) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AccountScreen(account: acc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clash Planner')),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (_, i) {
          final acc = accounts[i];
          final done = acc.tasks.where((t) => t.done).length;
          final total = acc.tasks.length;
          final now = DateTime.now();
          final timeLeft = acc.builderFreeAt != null
              ? acc.builderFreeAt!.difference(now)
              : null;

          return ListTile(
            title: Text(acc.name),
            subtitle: Text("Costruttore libero in: ${timeLeft != null ? _formatDuration(timeLeft) : 'non impostato'}"),
            isThreeLine: true,
            onTap: () => _openAccount(acc),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAccount,
        child: Icon(Icons.add),
      ),
    );
  }

  String _formatDuration(Duration d) {
    if (d.isNegative) return 'già libero';
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    return '${h}h ${m}m';
  }
}
