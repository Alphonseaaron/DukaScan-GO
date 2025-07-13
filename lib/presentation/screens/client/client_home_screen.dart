import 'package:dukascan_go/domain/models/store.dart';
import 'package:dukascan_go/domain/services/store_services.dart';
import 'package:dukascan_go/presentation/screens/client/store_home_screen.dart';
import 'package:flutter/material.dart';

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
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapViewScreen(stores: snapshot.data!),
                ),
              );
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
                      builder: (context) => StoreHomeScreen(storeId: store.id),
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

class _ListProducts extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Productsdb>>(
      future: productServices.getProductsTopHome(),
      builder: (_, snapshot) {
        
        final List<Productsdb>? listProduct = snapshot.data;

        return !snapshot.hasData
          ? Column(
              children: const [
                ShimmerFrave(),
                SizedBox(height: 10.0),
                ShimmerFrave(),
                SizedBox(height: 10.0),
                ShimmerFrave(),
              ],
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 20,
                mainAxisExtent: 220
              ),
              itemCount: listProduct?.length,
              itemBuilder: (_, i) 
                => Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsProductScreen(product: listProduct[i]))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Hero(
                            tag: listProduct![i].id, 
                            child: Image.network('http://192.168.1.35:7070/' + listProduct[i].picture , height: 150)
                          ),
                        ),
                        TextCustom(text: listProduct[i].nameProduct , textOverflow: TextOverflow.ellipsis, fontWeight: FontWeight.w500, color: ColorsFrave.primaryColor, fontSize: 19 ),
                        const SizedBox(height: 5.0),
                        TextCustom(text: '\$ ${listProduct[i].price.toString()}', fontSize: 16, fontWeight: FontWeight.w500 )
                      ],
                    ),
                  ),
                ),
            );
      },
    );
  }
}

