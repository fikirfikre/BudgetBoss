import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/on_boarding_list.dart';
import '../provider/on_boarding_provider.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  // int currentIndex = 0;
  PageController _controller = PageController();
  
  
  @override
  void initState(){
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<OnboardingProvider>(context);
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Column(
        
        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        const  SizedBox(),
                          Container(
                            
              width: 100,
              padding:const  EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
               // color: Colors.green.shade100
                
              ),
              child: TextButton(
                
                onPressed: (){
                  
                   _controller.jumpToPage(listOfContent.length-1);
                },
                child:provider.currentIndex == listOfContent.length - 1 ? const Text(""):
                  Text("Skip",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
              
                ),),
              ),  
                          ),
                        ],
                      ),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index){
                provider.setCurrentIndex(index);
              },
              itemCount: listOfContent.length,
              itemBuilder: (_,index){
                
                return Padding(
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
                  child: Column(
                   
                     children: [
                      
          
                       Image.asset(listOfContent[index].image,height: 250,),
                       Text(listOfContent[index].title,
                       style:const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                       ),),
                   const    SizedBox(height: 10,),
                        Text(
                          listOfContent[index].description,
                          style:const TextStyle(
                               fontSize: 16,
                               color: Colors.grey
                          ),
                          textAlign: TextAlign.center,),
                     
                
                       
                     ],
                  ),
                );
              }),
          ),
          Container(
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                listOfContent.length,
                 (index) => slidecontainer(index,context,provider ))
            ),
          ),
            Container(
              margin:const  EdgeInsets.fromLTRB(30, 30, 30, 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              
              width: MediaQuery.of(context).size.width,
              height: 50,        
              child: TextButton(onPressed: (){
                if(provider.currentIndex == listOfContent.length -1){
                       Navigator.pushNamed(context, RouteGenerator.login);
                }
               
                _controller.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.ease);
              },
              
             child:  Text(
              provider.currentIndex ==listOfContent.length-1 ? "Get Started" :"Next",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
             )),
            )
        ],
      
      ),
    );

  }

    Container slidecontainer(int index, context,provider) {
     
    return Container(
   margin: const EdgeInsets.all(2),
   height: 10,
   width:10,
   decoration: BoxDecoration(
     borderRadius: BorderRadius.circular(20),
     color: provider.currentIndex == index ? Theme.of(context).primaryColor : Colors.grey

   )
    );
}
}

















