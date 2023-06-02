import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp/Models/AdministratorModel/FoodItem.dart';
import 'package:fyp/Controllers/Administrator/FoodItemController.dart';
import 'package:fyp/Controllers/Administrator/FileUploadController.dart';
import 'package:fyp/Views/AdministrationView/SuccessfulSubmissionView.dart';
import 'dart:io' ;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
// import 'dart:io' as io;
class AddFoodItemView extends StatefulWidget {
  const AddFoodItemView({Key? key}) : super(key: key);

  @override
  State<AddFoodItemView> createState() => _AddFoodItemViewState();
}

class _AddFoodItemViewState extends State<AddFoodItemView> {
  String? surplusDescription;
  String? surplusID;
  File? _image;
  String? _category;
  String? _group;
  int? shelfLife;
  int? life;
  PlatformFile? selectedFile;

  final _formKey = GlobalKey<FormState>();
  final itemShelfLifeController = TextEditingController();
  final nameEditingController = TextEditingController();
  final surplusDescriptionController= TextEditingController();
  bool _showPrefix= false;
  // final surplus

  String? _selectedCategory;
  final List<String> _categoryValues = [
    'Snacks',
    'Sweets and Dessert',
    'Beverage',
    'Frozen Foods',
    'Protein and legumes',
    'Dairy'

  ];

  String? _selectedGroup;
  final List<String> _groupValues = [
    'Proteins',
    'Grains',
    'Fruits',
    'Vegetables',
    'Dairy',
    'Drinks',
    'Starchy'

  ];
File? file;

  final ImagePicker _picker = ImagePicker();

  Future <File?> pickImage() async{
    final file = await ImagePicker().getImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        if(file==null)return;
        if (file != null) {
          _image  = File(file.path) ;
        } else {
          print('No image selected.');
        }
      });
    }
  }

  void addFoodItem() async{
      String downloadUrl = await  FileUploadController().uploadImageToFirebase(_image);
      FoodItem foodItems = FoodItem(name:nameEditingController.text, category: _selectedCategory, group: _selectedGroup, shelfLife: shelfLife, image: downloadUrl);
      String addStatus  = await FoodItemController.addFoodItem(foodItems);
      if (addStatus == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessfulSubmissionView()),);
      } else {
        print (addStatus);
        // Display error message to user
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    leading: IconButton(
    icon: Icon(Icons.arrow_back, color:Colors.black ,),
    onPressed: () {
    Navigator.pop(context);
    },
    ),
    title: Text("Add Food Category", style: TextStyle(color: Colors.black),),
    backgroundColor: Colors.transparent,
    elevation: 0,
    ),

        body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
        Text("Add Food Item Details", style: TextStyle(
        color: Colors.black,
        fontSize:18,
        fontWeight: FontWeight.bold
        ),),

      SizedBox(height: 10),
      Container(
      child: Text("Add food items so the Sponsor can select surplus food from the given categories", style: TextStyle(
      color: Colors.black,
      fontSize:12,
      fontWeight:FontWeight.w300,

      ),),
      ),

      SizedBox(height: 10,),
      Container(
      width: 350,
      child: Form(
      key: _formKey,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
        'Name:',
        style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        ),
        ),
        Padding(
        padding: EdgeInsets.only(right:10, top:10),
        child:  TextFormField(

        controller: nameEditingController,
        maxLength:25,
        style: TextStyle(
        fontSize: 13,
        color: Colors.black,
        ),
        validator: (value) {
        if (value == null || value.isEmpty) {
        return 'Enter the name of food item';
        }
        },
        decoration:  InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical:1, horizontal:10),
        counterText: "",
        hintText: 'Name of the food item',
        hintStyle: TextStyle(

        color:GlobalColors.formLabel,
        fontWeight: FontWeight.w500,
        fontSize: 13
        ),

        )
        ),
        ),

      SizedBox(height: 30),


      Text(
      'Category:',
      style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
        color: Colors.black,
      ),
      ),
        Padding(
          padding: EdgeInsets.only(right:10, top:10),
          child:  Container(
            // width:300,
            height:73,
            child:DropdownButtonFormField<String>(
              style: TextStyle(fontSize: 12, color: Colors.black),
              value: _category,
              decoration: InputDecoration(
                labelText: 'Select a category',
                labelStyle: TextStyle(fontSize:13),
                hintText: 'category',
                border: OutlineInputBorder(),
              ),
              items: _categoryValues
                  .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter the category of food item';
                }
              },
            ),
          ),

        ),

      SizedBox(height: 30),


      Text(
      'Group:',
      style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      ),
      ),
        Padding(
          padding: EdgeInsets.only(right:10, top:10),
          child:  Container(
            // width:300,
            height:73,
            child:DropdownButtonFormField<String>(
              style: TextStyle(fontSize: 12, color: Colors.black),
              value: _category,
              decoration: InputDecoration(
                labelText: 'Select a food group',
                labelStyle: TextStyle(fontSize:13),
                hintText: 'group',
                border: OutlineInputBorder(),
              ),
              items: _groupValues
                  .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGroup = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter the group of food item';
                }
              },
            ),
          ),
        ),

      SizedBox(height: 30),


        Text(
          'Shelf Life(days):',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right:10, top:10),
            child: TextFormField(

              controller: itemShelfLifeController,
              keyboardType: TextInputType.number,

              validator: (value) {
                if (shelfLife == null) {
                  return 'Please enter a number only';
                }

                final life = this.shelfLife;
                if (life!=null) {
                  if(life<=1)
                    return 'Shelf life must be above 1 day';
                }
              },


              onChanged: (value) {
                shelfLife = int.tryParse(itemShelfLifeController.text);
                print(shelfLife);
              },


              // textAlign: TextAlign.center,
              decoration:  InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal:10),
                counterText: "",
                hintText: "Enter the shelf life",
                hintStyle: TextStyle(
                    color:GlobalColors.formLabel,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                ),

              ),
              style: TextStyle(fontSize: 13,),
            )
        ),


      SizedBox(height:30),

        Text(
          'Add Image:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right:10, top:10),
          child: Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                Container(
                width: 100,
                height:100,
                alignment: Alignment.center,
                color: GlobalColors.inputBorder,
                  child:IconButton(
                    iconSize: 40,
                    color: GlobalColors.titleHeading,
                    icon: Icon(Icons.add_a_photo_outlined),
                    onPressed: ()
                    {
                      pickImage();
                    },
                  ),
                ),
                  SizedBox(width: 5,),
                  Container(
                    width:100,
                    height:100,
                    decoration: BoxDecoration(
                      // color: GlobalColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: _image == null
                        ? Center(child:Text('No image selected') )
                        : Image.file(_image!, fit: BoxFit.cover,),

                  ),
                ],
              )


          )


        ),

      Container(
      margin: const EdgeInsets.all(38),
      width:300,
      height:40,
      child: ElevatedButton(
      style:ElevatedButton.styleFrom(
      primary: GlobalColors.titleHeading,

      ),
      onPressed: ()
      {
      // Validate returns true if the form is valid, or false otherwise.
      if (_formKey.currentState!.validate()) {

       addFoodItem();
      }

      // pickImage();
      },
      child: const Text('ADD FOOD ITEM',
      style:TextStyle(
      fontWeight: FontWeight.bold,
      )),
      )
      ),
      ],
      )
      )
      )

      ]
      ),


      ),
      )



    );
  }
}
