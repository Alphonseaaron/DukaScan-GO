import 'package:flutter/material.dart';
import 'package:dukascan_go/domain/models/store.dart';
import 'package:dukascan_go/domain/services/store_services.dart';
import 'package:dukascan_go/presentation/screens/client/map_view_screen.dart';
import 'package:dukascan_go/presentation/screens/client/store_home_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  final StoreService _storeService = StoreService();
  late Future<List<Store>> _storesFuture;

  @override
  void initState() {
    super.initState();
    _storesFuture = _storeService.getStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DukaScanGo'),
        actions: [
          FutureBuilder<List<Store>>(
            future: _storesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapViewScreen(stores: snapshot.data!),
                      ),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Store>>(
        future: _storesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final stores = snapshot.data!;
          return ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return ListTile(
                leading: Image.network(store.logo),
                title: Text(store.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoreHomeScreen(store: store),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

