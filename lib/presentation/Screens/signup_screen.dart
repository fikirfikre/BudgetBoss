import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String?  password;
  String? confirmPassword;
 
  SignUpPage({super.key});
  @override
  Widget build(BuildContext context){
    var cache = Provider.of<UserCache>(context);
    return  Scaffold(
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Login")),
                ],
              ),
              Image.asset("assets/on1.png",height: 300,),
              Text("Sign Up",style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
             ),),       
             Form(
              key: _formKey,
               child: Column(
                children:[
                TextFormField(
                  // controller: name,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your name";
                    }
                    
                  },
                  onSaved: (value)=> name = value!,
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
                TextFormField(
                  // controller:  email,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter your email";
                    }else if(!value.contains('@')){
                      return "Please enter a valid email address";
                    }
                  },
                  onSaved: (value)=>email=value!,
                  decoration:const InputDecoration(
                    label: Text("Email",style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                    ),),
                    hintText: "name@domain.com",  
                        hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    )           
                  ),
             
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please enter a password ";
                    }else if( value.length < 6){
                      return "Password must be at least 6 characters long";
                    }
                         password = value;
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
                TextFormField(
                  // controller: confirmPassword,
                  validator: (value){
                    print(password);
                          if(value!.isEmpty){
                            return "Please enter a the password again ";
         
                          }
         
                          
                          else if(value != password){
                            print(value);
                            return "The Password does not match. Please enter the password again";
                          }
                  },
                  onSaved: (value){
                    confirmPassword =value!;
                  },
                  decoration:const InputDecoration(
                    label: Text("confirm password",style: TextStyle(
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
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                    if(_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                        cache.registerUser(name, email, password);
                        _formKey.currentState!.reset();
                        // Navigator.pushNamed(context, RouteGenerator.login);
                    } 
                }, child: Text("Sign Up"))
                     ],
                    ),
             ),
             
            ]
           ),
         ),
       )
    
    );
  }
}