import 'package:budget_boss/presentation/Screens/statstics_screen.dart';
import 'package:budget_boss/presentation/provider/navigation_provider.dart';
import 'package:budget_boss/presentation/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Screens/daily_transaction_screen.dart';
import '../Screens/profile_screen.dart';
class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    super.key,
  });
  final pages = [
      DailyTransaction(),
    // const Statstics(),
    // const Budget(),
    // 
    // Container(),
    Statstics(),
    Container(),
  
    const Profile()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationProvider>(context);
    // var calendarProvider = Provider.of<CalendarProvider>(context);
    // print(calendarProvider.isWeek);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        
        Container(
          child: Container(
            color: Color.fromARGB(255, 250, 250, 250),
            child: Scaffold(
            //  backgroundColor: calendarProvider.isWeek ? Color.fromRGBO(0, 0, 0, 0.9):null,
          
              ///backgroundColor: calendarProvider.isWeek? Color.fromRGBO(164, 162, 162, 0.2) : null,
              body: pages[provider.pageIndex],
              bottomNavigationBar: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
          
                      height: 120,
                      decoration:
                          BoxDecoration(
                            
                            borderRadius: BorderRadius.circular(20)),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(12, 0, 13, 0),
                            height: 80,
                            decoration:const BoxDecoration(
                              // backgroundBlendMode: calendarProvider.isWeek? BlendMode.: null,
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(30))


                                ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      provider.changeIndex(0);
                                    },
                                    child: BottomIcon(
                                      label: "Daily",
                                      icon: Icons.calendar_month,
                                      color: provider.pageIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      iconColor: provider.pageIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade400,
                                      textColor: provider.pageIndex == 0
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    provider.changeIndex(1);
                                  },
                                  child: BottomIcon(
                                    label: "Stat",
                                    icon: Icons.analytics,
                                    color: provider.pageIndex == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    iconColor: provider.pageIndex == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    textColor: provider.pageIndex == 1
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 80,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    provider.changeIndex(2);
                                  },
                                  child: BottomIcon(
                                    label: "Budget",
                                    icon: Icons.wallet,
                                    color: provider.pageIndex == 2
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    iconColor: provider.pageIndex == 2
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    textColor: provider.pageIndex == 2
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => provider.changeIndex(3),
                                  child: BottomIcon(
                                    label: "Profile",
                                    icon: Icons.person,
                                    color: provider.pageIndex == 3
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    iconColor: provider.pageIndex == 3
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    textColor: provider.pageIndex == 3
                                        ? Colors.black
                                        : Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 35,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                            
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                     
                                      //color: Colors.white,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, RouteGenerator.addTransaction);
                                    },
                                    child: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // backgroundBlendMode: calendarProvider.isWeek? BlendMode.dstIn: null,
                      ),
                      
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
     
      ],
    );
  }
}

class BottomIcon extends StatelessWidget {
  const BottomIcon(
      {super.key,
      required this.label,
      required this.icon,
      required this.color,
      required this.iconColor,
      required this.textColor});
  final String label;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 50,
          height: 5,
          color: color,
        ),
        Icon(
          icon,
          color: iconColor,
        ),
        Text(
          label,
          style: TextStyle(color: textColor),
        )
      ],
    );
  }
}
