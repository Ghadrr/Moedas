import 'package:flutter/material.dart';
import '../services/request_http.dart';

class Favorites extends StatefulWidget {
  final List favorites;

  Favorites({Key? key, required this.favorites}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: FutureBuilder(
        future: widget.favorites.length > 0 ? getEspecifyCotacao(widget.favorites) : null,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<String> indexCoins = snapshot.data != null ? snapshot.data.keys.toList() : [];
            return ListView.builder(
              itemCount: indexCoins.length,
              itemBuilder: (context, index) {
                var moeda = snapshot.data[indexCoins[index]];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 10,
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text(
                        '${moeda['name']}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            '${moeda['code']}-${moeda['codein']}',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Mínimo hoje: R\$ ${moeda['low']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Máximo hoje: R\$ ${moeda['high']}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Agora: R\$ ${moeda['bid']}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
