import 'package:budget_boss/presentation/provider/user_cache.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  // bool isSwitched = false;
  // int index=0;
  List<bool> items = List.generate(2, (index) => false);
  @override
  Widget build(BuildContext context) {
    var userCache = Provider.of<UserCache>(context,listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:const Icon(Icons.arrow_back_outlined, size: 25,weight: 1,)),
               const SizedBox(width: 10,),
               const Text("Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900
                ),)
              ],
              
            ),
          const  SizedBox(height: 20,),
          TextButton(onPressed: (){
            userCache.logOUt();
            Navigator.pushNamed(context, RouteGenerator.bootScreen);
          }, child: Text("Log out")),
          settingWithButton(context, 0),
          settingWithButton(context, 1),
            Expanded(child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context,index){
                return settingsItem(context, index);
              })),
              
          ],
        ),
      ),
    );
  }

  Row settingWithButton(BuildContext context, int index) {
    return Row(
               
                children: [
                 const CircleAvatar(),
                 const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:MediaQuery.of(context).size.width/1.5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 const Text("Settings title here",style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  
                                  Text("Settings status",style: TextStyle(
                                    color: Colors.grey.shade400
                                  ),)
                                ],
                              ),
                             
                             Switch(value: items[index], onChanged: (value){
                              setState(() {
                                
                                items[index] = value;
                                print(index);
                              });
                              
                             },
                             activeColor: Theme.of(context).primaryColor,
                             )
                            //  activeTrackColor: Colors.lightGreenAccent,)
                            ],
                          ),
                        ),
                        Container(
                          
                          width:MediaQuery.of(context).size.width/1.5,
                          height: 1,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  )
                ],
              );



  }

                  Row settingsItem(BuildContext context, int index) {
    return Row(
               
                children: [
                 const CircleAvatar(),
                 const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width:MediaQuery.of(context).size.width/1.5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 const Text("Settings title here",style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  
                                  Text("Settings status",style: TextStyle(
                                    color: Colors.grey.shade400
                                  ),)
                                ],
                              ),
                           
                            //  activeTrackColor: Colors.lightGreenAccent,)
                            ],
                          ),
                        ),
                        Container(
                          
                          width:MediaQuery.of(context).size.width/1.5,
                          height: 1,
                          color: Colors.grey.shade300,
                        )
                      ],
                    ),
                  )
                ],
              );
  }
}