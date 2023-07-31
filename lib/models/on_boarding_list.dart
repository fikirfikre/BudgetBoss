import 'dart:core';
// ignore: empty_constructor_bodies
class OnboardingContent{
  String title;
  String image;
  String description; 
  
  OnboardingContent({required this.title, required this.image,required this.description});
}
List<OnboardingContent> listOfContent =[
  OnboardingContent(title: "Track Your Spending",
                    image: "assets/on1.png",
                    description: "Track and analyse spending immediately and automatically through our bank connection"
                    
,),
  OnboardingContent(title: "Budget Your Money",
                    image: "assets/on23.png",
                    description: "Build healthy financial habits. Control unnecessary expenses"
                    
                    ,),
OnboardingContent(title: "Connect your Bank",
                    image: "assets/on33.png",
                    description: "Connect all your accounts from any bank. Add savings, credit cards, PayPal and more"
                   ,)
];