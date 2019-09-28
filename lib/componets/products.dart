import 'package:HagereGebeya/model/productModel.dart';
import 'package:HagereGebeya/pages/posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:HagereGebeya/commons/common.dart';
import 'package:HagereGebeya/pages/product_details.dart';
import 'package:HagereGebeya/provider/CRUDModel.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

    List<Posts> postsList = [];
    

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");

    postsRef.once().then((DataSnapshot snap){
        // var KEYS = snap.value.key;
        
        // var result = snap.value.values as Iterable;
        postsList.clear();       
    
        Map<dynamic, dynamic> values = snap.value;
        print(values.toString());
          values.forEach((key,values) {
            Posts posts = new Posts(
              values['id'],
              values['image'],
              values['title'],
              values['price'],
              values['description'],
              values['date'],
              values['time']
            );
           postsList.add(posts);
            // print(values["price"]);
        });
        setState(() {
         print('Length:$postsList.length'); 
        });
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: postsList.length,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, index) {
          // print("================================>"+postsList[index].title);
          return Single_prod(
            prod_name: postsList[index].title,
            prod_pricture: postsList[index].image,
            prod_description: postsList[index].description,
            prod_price: postsList[index].price,
          );
        });
  }
}

class Single_prod extends StatelessWidget {
  final prod_id;
  final prod_name;
  final prod_pricture;
  final prod_description;
  final prod_price;

  Single_prod({
    this.prod_id,
    this.prod_name,
    this.prod_pricture,
    this.prod_description,
    this.prod_price,
  });

    @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350],
                blurRadius:
                10.0, // has the effect of softening the shadow
              )
            ],
          ),
            child: Material(
              borderRadius: BorderRadius.circular(40),
              child: InkWell(
                 onTap: ()=> Navigator.of(context).push(
                new MaterialPageRoute(builder: (context)=>new ProductDetails(
                  //here we are passing the values of the product to the product detail
                  product_id: prod_id,
                  product_detail_name: prod_name,
                  product_detail_new_price: prod_price,
                  product_detail_description: prod_description,
                  product_detail_picture: prod_pricture,
                ))),
                child: GridTile(
                    footer: Container(
                      color: Colors.white70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(prod_name, style: TextStyle(fontSize: 19, color: black, fontWeight: FontWeight.w300),),
                          Text(
                            "Br. $prod_price",
                            style: TextStyle(
                                color: black,fontSize: 19, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ),
                    // if its from file we use image.asset or image.network for online images
                    child: Image.network(
                      prod_pricture,
                      fit: BoxFit.cover,
                    )),
              ),
            )
      ),
    );
  }
}

