import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _noteController = TextEditingController();

  final snackBar = const SnackBar(
    content: Text('Note saved'),
  );

  Future<void> _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _noteController.text = (prefs.getString('note') ?? '');
    });
  }

  Future<void> _addNote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('note', _noteController.text);
    });
  }

  @override
  void initState() {
    _loadNote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: height * 3 / 4,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 30,
                  controller: _noteController,
                  decoration: const InputDecoration(
                    hintText: 'Catatan',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _addNote();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: const Text('Tutup Catatan Rahasia'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
