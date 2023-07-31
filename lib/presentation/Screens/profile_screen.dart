import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isHover  = false;
  @override
  Widget build(BuildContext context) {
    return 
      // padding: const EdgeInsets.all(20.0),
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            padding:const EdgeInsets.fromLTRB(20, 20, 20, 40),
              // height: MediaQuery.of(context).size.height/2.2,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom:Radius.circular(50)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const Text("Profile", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                      IconButton(icon: const Icon(Icons.settings_outlined),
                      onPressed: (){
                         Navigator.pushNamed(context, RouteGenerator.setting);
                      },)
                    ],
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    InkWell(
                      onTap: (){},
                      onHover: (value) {
                        setState(() {
                          isHover= value;
                        });
                        
                        print(isHover);
                      },
                  
                      child: SizedBox(
                        width: 200,
                        height: 110,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                             
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(context).primaryColor
                              ),
                            ),
                            
                      
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(80)
                              ),
                            ),
                           InkWell(
                            onTap: (){
                              
                            },
                           
                            child: const CircleAvatar(backgroundImage:AssetImage("assets/congra.png"),radius: 40,)),
                           Positioned(
                             top:5,
                             left: 125,
                             child: Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: const Text("B+",style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                              ),),
                             ),
                           ),
                           isHover?
                             Positioned(
                            
                           bottom: 20,
                        
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 200,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(66, 255, 255, 255),
                              
                                    ),
                            child:const InkWell(
                              //  onTap: _onAlertPress,
                             
                              child:  Icon(
                                Icons.add_a_photo,
                                size: 25.0,
                                color: Color(0xFF404040),
                              ),
                            ),
                          )):Container()
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const  Text("Abbie Wilson",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900
                        ),),
                       const SizedBox(height: 10,),
                        Text("Credit score: 73.50",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    )
                
                    
                  ],),
                  SizedBox(height: 20,),
      
            Container(
               padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              
              alignment: Alignment.center,
              width: double.infinity,
              // height: 130,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      Text("United Bank Asia",style: 
                      TextStyle(
                        color: Colors.white
                      ),
                      textAlign: TextAlign.center,)
                      ,
                      Text("\$2446.90", style: TextStyle(
      
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),)
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                     
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white,width: 1),
                      
                    ),
                    child:const Text("Update",style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),),
                  )
                ],
              ),
            ),
          
                ],
              ),
            ),
          infoWidget("Email","jparker@gmail.com"),
          infoWidget("Date of birth", "04-19-1992"),
          infoWidget("Password", "..........")
      
      
           
       
      
            
          ],
          
          
      );
  }

  Padding infoWidget(title,label) {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50,5),
      child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 8,),
                 Text(label,style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
          
              ],
            ),
    );
  }
}