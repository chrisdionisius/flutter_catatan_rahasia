import 'package:flutter/material.dart';
import 'package:flutter_catatan_rahasia/pages/notes_page.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _pinController = TextEditingController();

  final snackBar = const SnackBar(
    content: Text('Invalid Pin'),
  );

  bool _isPinValid() {
    if (_pinController.text == '113355') {
      return true;
    }
    return false;
  }

  bool _passwordHidden = true;

  void _showPassword() {
    setState(() {
      _passwordHidden = !_passwordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                obscureText: _passwordHidden,
                controller: _pinController,
                decoration: InputDecoration(
                  hintText: 'PIN',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _showPassword();
                    },
                    icon: (_passwordHidden)
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _isPinValid()
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotesPage();
                            },
                          ),
                        )
                      : ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
