import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
    String title;
    String description;
    double price;
    File sampleImage;
    // String productTitle;
    String url;
    final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('Add Product'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
  
    body: new Center(
      child: sampleImage == null? Text("Select an Image"): enableUpload(),
    ),
    floatingActionButton:  new FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Add Image',
      child: new Icon(Icons.add_a_photo),
    ),
    );
  }
  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
     sampleImage = tempImage; 
    });
  }
  void uploadStatusImage() async {
    final StorageReference postImageRef = FirebaseStorage.instance.ref().child("post Images");

    var timeKey = new DateTime.now();

    final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString()).putFile(sampleImage);

    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    url = imageUrl.toString();

    print("Image Url" + url);
    SnackBar(
      content: Text("Successfully Posted")
    );
    saveToDatabase(url);
  }
  bool validateAndSave(){
    final form = formKey.currentState;

    if(form.validate())
    {
      form.save();
      uploadStatusImage();
    // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      return true;
    }
  }
  void saveToDatabase(url) {
      var dbTimeKey = new DateTime.now();
      
      var formatDate = new DateFormat('MMM d, yyyy');
      var formatTime = new DateFormat('EEEE, hh:mm aaa');

      String date = formatDate.format(dbTimeKey);
      String time = formatTime.format(dbTimeKey);


      DatabaseReference ref = FirebaseDatabase.instance.reference();

      var data = {

        "image": url,
        "description": description,
        "title": title,
        "price": price,
        "date": date,
        "time": time 
      };

      ref.child("Posts").push().set(data);
  }
// TODO: correct floating button , change the ui for addproduct, fix imagepicker
  Widget  enableUpload(){

    return Container(

      child: new Form(
        key: formKey,

      child: Column(
          children: <Widget>[
            Image.file(sampleImage,height: 310.0, width: 600.0,),

            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(labelText: 'Description'), 
              onSaved: (value){
                description = value;
              },    
            ),
            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(labelText: 'Title'), 
              onSaved: (value){
                title = value;
              },    
            ),
            SizedBox(height: 15.0,),

            TextFormField(
              decoration: new InputDecoration(labelText: 'Price'), 
              onSaved: (value){
                price = double.parse(value);
              },    
            ),
            SizedBox(height: 15.0,),

            RaisedButton(
              elevation: 10.0,
              child: Text("Add a New Post"),
              textColor: Colors.white,
              color: Colors.orange,

              onPressed: validateAndSave,
            )
          ],
      ),
      ),
    );
  }
}

