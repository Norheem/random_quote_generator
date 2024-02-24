import 'package:flutter/material.dart';
import 'package:random_quote_generator/screens/favourites_screen.dart';
import 'package:random_quote_generator/screens/quote_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String quote = '';

  int _selectedPageIndex = 0;
  final List<String> favoriteQuotes = [];

  void _selectPage(int index) {
    if (index == 1) {}
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void updateQuote(String newQuote) {
    setState(() {
      quote = newQuote;
    });
  }

  void onFavorite(String quote) {
    if (favoriteQuotes.contains(quote)) {
      favoriteQuotes.remove(quote);
    } else {
      favoriteQuotes.add(quote);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = QuoteScreen(
      quote: quote,
      onUpdate: updateQuote,
      onFavorite: (quote) {
        if (!favoriteQuotes.contains(quote)) {
          setState(() {
            favoriteQuotes.add(quote);
          });
        }
      },
    );
    var activeScreenTitle = 'Random Quote Generator';

    if (_selectedPageIndex == 1) {
      activeScreen = FavouritesScreen(
        favoriteQuotes: favoriteQuotes,
        onRemoveFavorite: (quote) {
          setState(() {
            favoriteQuotes.remove(quote);
          });
        },
      );
      activeScreenTitle = 'Your Favourite Quotes';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 68, 132),
        title: Text(activeScreenTitle),
        centerTitle: true,
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedLabelStyle:
            TextStyle(fontSize: _selectedPageIndex == 0 ? 20 : 20),
        unselectedLabelStyle:
            TextStyle(fontSize: _selectedPageIndex == 0 ? 16 : 16),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedPageIndex == 0 ? Icons.home : Icons.home_outlined,
              color: _selectedPageIndex == 0 ? Colors.white : Colors.black,
            ),
            label: _selectedPageIndex == 0 ? 'Home' : 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedPageIndex == 1 ? Icons.star : Icons.star_border,
              color: _selectedPageIndex == 1 ? Colors.white : Colors.black,
            ),
            label: _selectedPageIndex == 1 ? 'Favourite' : 'Favourite',
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 4, 68, 132),
      ),
    );
  }
}
