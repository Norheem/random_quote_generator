// import 'package:flutter/material.dart';

// class FavouritesScreen extends StatefulWidget {
//   final List<String> favoriteQuotes;
//   final Function onRemoveFavorite;

//   const FavouritesScreen({
//     Key? key,
//     required this.favoriteQuotes,
//     required this.onRemoveFavorite,
//   }) : super(key: key);

//   @override
//   State<FavouritesScreen> createState() => _FavouritesScreenState();
// }

// class _FavouritesScreenState extends State<FavouritesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           const Text(
//             'Your Favourite Quotes',
//             style: TextStyle(color: Colors.purple, fontSize: 30),
//           ),
//           // Display favorite quotes here
//           ListView.builder(
//             itemCount: widget.favoriteQuotes.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(widget.favoriteQuotes[index]),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  final List<String> favoriteQuotes;
  final Function(String) onRemoveFavorite;

  const FavouritesScreen({
    Key? key,
    required this.favoriteQuotes,
    required this.onRemoveFavorite,
  }) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            const Text(
              'No Favourite Quotes',
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 68, 132), fontSize: 30),
            ),
            // Display favorite quotes here
            for (String quote in widget.favoriteQuotes)
              ListTile(
                title: Text(quote),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    widget.onRemoveFavorite(quote);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
