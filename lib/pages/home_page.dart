import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/pages/signup_page.dart';
import 'package:flutter_database/services/db_services.dart';
import 'package:hive/hive.dart';

import '../model/user_model.dart';

class HomePage extends StatefulWidget {
 static final String id = "home_page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

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
                    padding: EdgeInsets.only(top: 40,left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //#image
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/user_5.jpeg"))),
                        ),
                        SizedBox(height: 25,),
                        Text("Welcome", style: TextStyle(color: Colors.white60),),
                        SizedBox(height: 5,),
                        Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,),
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
                            Text("Email", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                            SizedBox(height: 5,),
                            TextField(
                              style: TextStyle(fontSize: 14),
                              controller: nameController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[400]!)
                                ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(fontSize: 14)
                              ),
                            ),
                            SizedBox(height: 20,),
                            Text("Password", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                            SizedBox(height: 5,),
                            TextField(
                              style: TextStyle(fontSize: 14),
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[400]!)
                                ),
                                hintText: "Password",
                              ),
                            ),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Forget Password?", style: TextStyle(color: Colors.grey[400]),)
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.teal[400],
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              child: TextButton(
                                  onPressed: _doLogin,
                                  child:Text("Sign In", style: TextStyle(color: Colors.white),)
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
                                      Text("Don't have an account?  ", style: TextStyle(color: Colors.grey[400]),),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.pushReplacementNamed(context, SignUpPage.id);
                                        },
                                        child: Text("Sign Up", style: TextStyle(color: Colors.teal[500]),),
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
    String name = nameController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    var user = User(name, password);

    HiveDB().store("user", user.toJson());

    var user2 = HiveDB().loadUser("user");
    print(user2.name);
    print(user2.password);
  }
}
