import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database/model/account_model.dart';
import 'package:flutter_database/pages/home_page.dart';
import '../model/user_model.dart';
import '../services/db_services.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[300],
        body:CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 30,left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: 25,),
                          Text("Welcome", style: TextStyle(color: Colors.white60),),
                          SizedBox(height: 5,),
                          Text("Sign Up ", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 80, left: 30, right: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Email", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                              SizedBox(height: 5,),
                              TextField(
                                style: TextStyle(fontSize: 14),
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey[400]!)
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(fontSize: 14)
                                ),
                              ),

                              SizedBox(height: 50,),

                              Text("Number", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                              SizedBox(height: 5,),
                              TextField(
                                style: TextStyle(fontSize: 14),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]+"))],
                                controller: numberController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[400]!)
                                  ),
                                  hintText: "Number",
                                ),
                              ),

                              SizedBox(height: 50,),

                              Text("Address", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),),
                              SizedBox(height: 5,),
                              TextField(
                                style: TextStyle(fontSize: 14),
                                controller: addressController,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[400]!)
                                  ),
                                  hintText: "Address",
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 40),
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.teal[400],
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: TextButton(
                                    onPressed: _doLogin,
                                    child:Text("Sign Up", style: TextStyle(color: Colors.white),)
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(child:  Container(
                                    height: 1,
                                    color: Colors.grey[200],
                                  ),),
                                  SizedBox(width: 20,),
                                  Text("OR", style: TextStyle(color: Colors.grey[400])),
                                  SizedBox(width: 20,),
                                  Expanded(child:  Container(
                                    height: 1,
                                    color: Colors.grey[200],
                                  ),),
                                ],
                              ),
                              SizedBox(height: 50,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Image(image: AssetImage("assets/images/ic_facebook.jpeg")),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 40, right: 40),
                                    height: 20,
                                    width: 20,
                                    child: Image(image: AssetImage("assets/images/ic_twitter.jpeg")),
                                  ),

                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Image(image: AssetImage("assets/images/ic_instagram.jpeg")),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    padding: EdgeInsets.only(bottom: 25, top: 25),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Already have an account?  ", style: TextStyle(color: Colors.grey[400]),),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pushReplacementNamed(context, HomePage.id);
                                          },
                                          child: Text("Sign In", style: TextStyle(color: Colors.teal[500]),),
                                        )
                                      ],
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }

  void _doLogin(){
    String email = emailController.text.toString().trim();
    String number = numberController.text.toString().trim();
    String address = addressController.text.toString().trim();

    var account = Account(email, number, address);

    HiveDB().store("account", account.toJson());

    var account2 = HiveDB().loadAccount("account");
    print(account2.email);
    print(account2.number);
    print(account2.address);
  }
}
