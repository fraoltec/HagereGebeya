import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_tut/commons/common.dart';

//my own imports
import 'package:shopapp_tut/componets/horizontal_listview.dart';
import 'package:shopapp_tut/componets/products.dart';
import 'package:shopapp_tut/pages/addProduct.dart';
import 'package:shopapp_tut/pages/cart.dart';
import 'package:shopapp_tut/pages/product_details.dart';
import 'package:shopapp_tut/provider/user_provider.dart';
  

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();


}

class _HomePageState extends State<HomePage> {
  TextEditingController _search = TextEditingController();
 int currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
   void getName () async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    
    print("email : =================================>"+user.email);    
  }
 
  @override
  Widget build(BuildContext context) {
    
  Widget image_carousel = new Container(
    height: 200.0,
    child:  new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('images/w3.jpeg'),
        AssetImage('images/m1.jpeg'),
        AssetImage('images/c1.jpg'),
        AssetImage('images/w4.jpeg'),
        AssetImage('images/m2.jpg'),
      ],
      autoplay: true,
     animationCurve: Curves.fastOutSlowIn,
     animationDuration: Duration(milliseconds: 1500),
// To change the UI for home carousel 
      dotSize: 4.0,
      indicatorBgPadding: 2.0,
      dotBgColor: Colors.transparent,
    ),
  );
    // final user = Provider.of<UserProvider>(context);
    
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: deepOrange),
        elevation: 0.1,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: TextFormField(
            controller: _search,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                hintText: "Search...",
                border: InputBorder.none),
            validator: (value) {
              if (value.isEmpty) {
                return "The search field cannot be empty";
               
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                getName();
              }),
              // the top right shopping cart icon 
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
              onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
              })
        ],
      ),
//       drawer: new Drawer(
//         child: new ListView(
//           children: <Widget>[
// //            header
//             new UserAccountsDrawerHeader(
                
//                 accountName: Text(''),
//                 accountEmail: Text(''),
//             currentAccountPicture: GestureDetector(
//               child: new CircleAvatar(
//                 backgroundColor: Colors.grey,
//                 child: Icon(Icons.person, color: Colors.white,),
//               ),
//             ),
//             decoration: new BoxDecoration(
//               color: deepOrange
//             ),
//             ),

// //            body

//           // InkWell(
//           //   onTap: (){},
//           //   child: ListTile(
//           //     title: Text('Home Page'),
//           //     leading: Icon(Icons.home, color: Colors.grey,),
//           //   ),
//           // ),
//             InkWell(
//               onTap: (){},
//               child: ListTile(
//                 title: Text('My account'),
//                 leading: Icon(Icons.person, color: Colors.grey,),
//               ),
//             ),

//             InkWell(
//               onTap: (){},
//               child: ListTile(
//                 title: Text('My Orders'),
//                 leading: Icon(Icons.shopping_basket, color: Colors.grey,),
//               ),
//             ),

//             InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => new Cart()));
//               },
//               child: ListTile(
//                 title: Text('Shopping Cart'),
//                 leading: Icon(Icons.shopping_cart, color: Colors.grey,),
//               ),
//             ),
//           InkWell(
//               onTap: (){
//                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> new AddProduct()));
                
//               },
//               child: ListTile(
//                 title: Text('Add Product'),
//                 leading: Icon(Icons.add_a_photo, color: Colors.grey,),
//               ),
//             ),
//             InkWell(
//               onTap: (){},
//               child: ListTile(
//                 title: Text('Favourites'),
//                 leading: Icon(Icons.favorite, color: Colors.grey,),
//               ),
//             ),

//             Divider(),

//             InkWell(
//               onTap: (){},
//               child: ListTile(
//                 title: Text('Settings'),
//                 leading: Icon(Icons.settings, color: Colors.grey,),
//               ),
//             ),

//             InkWell(
//               onTap: (){
//                 user.signOut();
//               },
//               child: ListTile(
//                 title: Text('Log Out'),
//                 leading: Icon(Icons.transit_enterexit, color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),

      body: new ListView(
        children: <Widget>[
          //image carousel begins here
          image_carousel,

          //padding widget
          new Padding(padding: const EdgeInsets.all(8.0),
          child: new Text('Categories'),),

          //Horizontal list view begins here
          HorizontalList(),

          //padding widget
          new Padding(padding: const EdgeInsets.all(20.0),
            child: new Text('Recent products'),),

          //grid view
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: currentIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            currentIndex = index;
            if(index == 0){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }else if(index == 1){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
            }else if(index == 2){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
            }else if(index == 3){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }
          }),
          
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: black,
              
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Users'),
                activeColor: black
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text('Messages'),
                activeColor: black
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: black
            ),
          ],
        )
    );
  }
}

