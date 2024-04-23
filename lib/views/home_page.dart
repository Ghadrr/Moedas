import 'package:cotacaomoedas/views/favorites.dart';
import 'package:flutter/material.dart';
import '../services/request_http.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> favorites = [];
  TextEditingController filterController = TextEditingController();

  void filter(String filtro) {
    setState(() {});
  }

  void add_favorite(String code) {
    setState(() {
      if (favorites.contains(code)) {
        favorites.remove(code);
      } else {
        favorites.add(code);
      }
    });
  }

  void navigate_favorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Favorites(favorites: favorites),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coins", style: TextStyle(color: Colors.amber)),
        actions: [
          IconButton(
            onPressed: navigate_favorites,
            icon: Icon(Icons.star),
            color: Colors.amber,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                labelText: 'Filter',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: filter,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getCotaCoin(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  List<String> indexMoedas = snapshot.data.keys.toList();
                  List<String> moedasFiltradas = indexMoedas
                      .where((moeda) => moeda.contains(filterController.text))
                      .toList();
                  return ListView.builder(
                    itemCount: moedasFiltradas.length,
                    itemBuilder: (context, index) {
                      var moeda = snapshot.data[moedasFiltradas[index]];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text('${moeda['name']}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${moeda['code']}-${moeda['codein']}'),
                                Text('Mínimo Hoje: R\$ ${moeda['low']}'),
                                Text('Máximo Hoje: R\$ ${moeda['high']}'),
                                Text('Agora: R\$ ${moeda['bid']}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                favorites.contains(
                                        '${moeda['code']}-${moeda['codein']}')
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.green,
                              ),
                              onPressed: () => add_favorite(
                                  '${moeda['code']}-${moeda['codein']}'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
