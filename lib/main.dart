import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});
}

class ProductList extends StatefulWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    products = widget.products;
  }

  void buyProduct(Product product) {
    setState(() {
      product.counter++;
      if (product.counter == 5) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Congratulations!'),
              content: Text('You\'ve bought 5 ${product.name}!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${product.counter}'),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: ElevatedButton(
                    onPressed: () => buyProduct(product),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  int getTotalProducts() {
    int total = 0;
    for (var product in products) {
      total += product.counter;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Products: ${getTotalProducts()}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Product List'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(name: "Product 1", price: 10.0),
    Product(name: "Product 2", price: 15.0),
    Product(name: "Product 3", price: 20.0),
    Product(name: "Product 4", price: 25.0),
    Product(name: "Product 5", price: 30.0),
    Product(name: "Product 6", price: 35.0),
    Product(name: "Product 7", price: 40.0),
    Product(name: "Product 8", price: 45.0),
    Product(name: "Product 9", price: 50.0),
    Product(name: "Product 10", price: 55.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ProductList(products: products),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(products: products),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
