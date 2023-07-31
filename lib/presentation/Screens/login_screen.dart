import 'dart:convert';

import 'package:budget_boss/presentation/provider/account_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../provider/user_cache.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;

  String? password;

  final _formKey = GlobalKey<FormState>();

  UserCache cache = UserCache();

  FlutterSecureStorage? secureStorage;

  bool _isloading = false;

  Future<void> loadSavedCredencials() async{
    final email = await secureStorage?.read(key: 'email');
    final password = await secureStorage?.read(key: 'password');

    if(email != null && password != null){
      Navigator.of(context).pushReplacementNamed(RouteGenerator.home);
    }
  }

  @override
  Widget build(BuildContext context) {
  var cache = Provider.of<UserCache>(context);
  var account = Provider.of<AccountCache>(context);
    return Scaffold(
      body: SingleChildScrollView(child:Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: (){

                Navigator.of(context).pushNamed(RouteGenerator.signup);
              }, child: Text("Sign Up"))
            ],
          ),
          Image.asset("assets/on1.png", height: 300,),
          Text("LogIn",style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
             )),
             Form(
              key:_formKey,
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please enter your name";
                        }
                      },
                      onSaved: (value)=> username = value!,
                      decoration:const InputDecoration(
                      label: Text("Name",style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),),
                      hintText: "your name",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                      )
                      
                    ),
                    ),
                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "Please enter a password ";
                                                      }else {
                                                           password = value;
                                                      }
                                                    },
                                                   
                                                 
                                                   
                                                    // controller: password,
                                                    decoration:const InputDecoration(
                                                      label: Text("password",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold
                                                      ),),
                                                      hintText: "password",
                                                          hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 14
                                                      )
                                                    ),
                                                  ),
                                  ),
                SizedBox(height: 50,),
                ElevatedButton(onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        bool isUser = await cache.getUser(username, password);
                        
                        if(isUser){
                         await secureStorage?.write(key: 'user_name',value: username);
                         await secureStorage?.write(key: 'password', value: password);
                         final token = base64Url.encode(utf8.encode("$username:$password:${DateTime.now().microsecondsSinceEpoch}"));

                          // ignore: use_build_context_synchronously
                         bool acc = await account.getAccount(cache.user?.id);
                          if(acc){
                             Navigator.of(context).pushReplacementNamed(RouteGenerator.home);       
                          } else{
                          Navigator.of(context).pushReplacementNamed(RouteGenerator.currencyScreen);
                          }
                        } else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Wrong username or passowrd"))
                          );
                        }
                      
                    } 
                    // print(cache.isUser);
                    // if(cache.isUser == true){
                    //   Navigator.of(context).pushNamed(RouteGenerator.currencyScreen);
                    // }else if(cache.isUser == false){
                      
                    //  ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text("Wrong username or password. Please try again.",
                    //   ),backgroundColor: Colors.red,)
                    //  );
                    // }else{
                    //   CircularProgressIndicator();
                    // }

                }, child: Text("Log In")),
               

                ],
              ) 
             )
        ]),
      )),
    );
  }

  Consumer<UserCache> gettingUser(userName,password) {
    
    return Consumer<UserCache>(
      
                builder: (context, cache, child) {
                  print("he");
                  return FutureBuilder(
                    future: cache.getUser(userName, password),
                    builder: (context,snapshot){
                      print(snapshot.data);
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }else if (snapshot.data == true){
                                    return Container();
                      }else if(snapshot.data == false){
                        print("hello");
                        return  
                    SnackBar(content: Text("Wrong username or password. Please try again.",
                    ),backgroundColor: Colors.red,)
                   ;
                      }else{
                        return Container();
                      }
                    },
                    );
                },
              );
  }
}