import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({
    Key? key,
    required void Function(String quote) onFavorite,
    required this.quote,
    required this.onUpdate,
  }) : super(key: key);

  final String quote;
  final Function onUpdate;
  void onFavorite(String quote) {}

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String quote = '';
  bool quoteFetched = false;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      quoteFetched ? widget.quote : 'No Quote Yet',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 4, 68, 132),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.star : Icons.star_border,
                        color: const Color.fromARGB(255, 4, 68, 132),
                      ),
                      onPressed: () {
                        // Toggle the favorite status of the quote
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        widget.onFavorite(widget.quote);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: updateQuote,
              child: Container(
                alignment: Alignment.center,
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 4, 68, 132),
                ),
                child: const Text(
                  'Get Quote',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> getQuote() async {
    try {
      String apiUrl = 'https://api.adviceslip.com/advice';

      http.Response response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> content = jsonDecode(response.body);
        return content['slip']['advice'].toString();
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      print('API Request Error: $e');
      return null;
    }
  }

  void updateQuote() {
    getQuote().then((quote) {
      if (quote != null) {
        setState(() {
          widget.onUpdate(quote);
          quoteFetched = true;
        });
      }
    });
  }
}
