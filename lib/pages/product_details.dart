import 'package:flutter/material.dart';
import 'package:HagereGebeya/commons/common.dart';
import 'package:HagereGebeya/componets/products.dart';
import 'package:HagereGebeya/model/productModel.dart';
// import 'package:HagereGebeya/ViewModels/CRUDModel.dart';
import 'home.dart';

class ProductDetails extends StatefulWidget {
  final product_id;
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_description;
  final product_detail_picture;

  ProductDetails({
    this.product_id,
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_description,
    this.product_detail_picture,
  });

  //ProductDetails({Key key}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  final Product product = new Product();

  

  @override
  Widget build(BuildContext context) {
    //  final productProvider = Provider.of<CRUDModel>(context);
     
    // var bloc = Provider.of<CartBloc>(context);
    // int totalCount = 0;
    // if (bloc.cart.length > 0) {
    //   totalCount = bloc.cart.values.reduce((a, b) => a + b);
    // }
    return Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: deepOrange),
               onPressed: () => Navigator.of(context).pop(),
              ), 
          elevation: 0.1,
          backgroundColor: white,
          title: InkWell(
              // route to a different page
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new HomePage()));
              },
              child: Text('Hagere Gebeya',style: TextStyle(color: deepOrange),)),
          // actions: <Widget>[
          //   new IconButton(
          //       icon: Icon(
          //         Icons.search,
          //         color: deepOrange,
          //       ),
          //       onPressed: () {}),
          // ],
        ),
        body: new ListView(
          children: <Widget>[
            //this is the prod detail for diplaying image
            new Container(
              height: 300.0,
              child: GridTile(
                child: Container(
                  color: Colors.white,
                  child: Image.network(widget.product_detail_picture),
                ),
                footer: new Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: new Text(
                      widget.product_detail_name,
                      style: TextStyle(fontSize: 19, color: black, fontWeight: FontWeight.w300),
                          
                    ),
                    title: new Row(
                      children: <Widget>[
                        // Expanded(
                        //   child: new Text("Br. ${widget.product_detail_old_price}",
                        //   style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),)
                        // ),
                        Expanded(
                            child: new Text(
                          "Br. ${widget.product_detail_new_price}",textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
           
            // =========================== The second Button(Buy button) =============
            Row(
              children: <Widget>[
                // ================ the Size button ===========
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text("Buy Now"),
                  ),
                ),
                new IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: deepOrange,
                  ),
                  onPressed: () {
                    // bloc.addToCart(widget.product_detail_name);
                  },
                ),
                new IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: deepOrange,
                  onPressed: () {},
                ),
              ],
            ),
            Divider(),
            new ListTile(
              title: new Text("Item Details "),
              subtitle: new Text("${widget.product_detail_description}"),
              //  new Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
            ),
            Divider(),
            new Row(
              // add who posted the product
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                  child: new Text(
                    "Made by:",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                // Create The product Brand
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: new Text("Made by"),
                )
              ],
            ),
           
            // Similar Products Section
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text("Similar Products",textAlign: TextAlign.center),
            ),
            Container(
              height: 340.0,
              child: Products(),
            )
          ],
        ));
  }
}

class Similar_products extends StatefulWidget {
  @override
  _Similar_productsState createState() => _Similar_productsState();
}

class _Similar_productsState extends State<Similar_products> {
  @override
  Widget build(BuildContext context) {}
}

class Similar_single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_description;
  final prod_price;

  Similar_single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_description,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          // does product name have to be different
          tag: new Text("Product 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) => new ProductDetails(
                        //here we are passing the values of the product to the product detail
                        product_detail_name: prod_name,
                        product_detail_new_price: prod_price,
                        product_detail_description: prod_description,
                        product_detail_picture: prod_pricture,
                      ))),
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    // Change the UI for recent products Video 19(14:19)
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "Br. $prod_price",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "$prod_description",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  child: Image.asset(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
