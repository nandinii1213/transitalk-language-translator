import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 14, 17, 23),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: const Color.fromARGB(128, 244, 67, 54),
          selectionHandleColor: Colors.red,
        )
      ),
      home: TranslatorScreen(),
    );
  }
}

class TranslatorScreen extends StatefulWidget {
  @override
  _TranslatorScreenState createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _textController = TextEditingController();
  final GoogleTranslator _translator = GoogleTranslator();
  String _translatedText = "";

  final Map<String, String> _languages = {
    'English': 'en',
    'Hindi': 'hi',
    'Marathi': 'mr',
    'French': 'fr',
    'German': 'de',
  };

  String _fromLanguage = 'en';
  String _toLanguage = 'hi';

  void _translateText() async {
    if (_textController.text.isNotEmpty) {
      final translation = await _translator.translate(
        _textController.text,
        from: _fromLanguage,
        to: _toLanguage,
      );
      setState(() {
        _translatedText = translation.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TransiTalk", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)), backgroundColor: const Color.fromARGB(255, 14, 17, 23), surfaceTintColor: const Color.fromARGB(255, 14, 17, 23), iconTheme: IconThemeData(color: Colors.black)), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Enter text to translate",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Color.fromARGB(255, 38, 39, 48),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 39, 48),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _fromLanguage,
                    onChanged: (value) {
                      setState(() {
                        _fromLanguage = value!;
                      });
                    },
                    dropdownColor: Color.fromARGB(255, 38, 39, 48),
                    style: TextStyle(color: Colors.white),
                    underline: SizedBox(),
                    items: _languages.entries
                        .map((entry) => DropdownMenuItem(
                              value: entry.value,
                              child: Text(entry.key, style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward, color: Colors.white),
                const SizedBox(width: 6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 39, 48),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _toLanguage,
                    onChanged: (value) {
                      setState(() {
                        _toLanguage = value!;
                      });
                    },
                    dropdownColor: Color.fromARGB(255, 38, 39, 48),
                    style: TextStyle(color: Colors.white),
                    underline: SizedBox(),
                    items: _languages.entries
                        .map((entry) => DropdownMenuItem(
                              value: entry.value,
                              child: Text(entry.key, style: TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _translateText,
              child: Text("Translate"),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: const Color.fromARGB(255, 38, 39, 48)
              ),
              child: Text(
                _translatedText,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}