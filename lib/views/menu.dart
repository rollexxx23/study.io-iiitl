import 'package:flutter/material.dart';

final Color backgroundColor = Colors.blue;

// (0xFF90CAF9);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> {
  bool isCollapsed = true;
  double screenWidth,screenHeight;
  final Duration duration=const Duration(microseconds: 3000);
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    screenHeight=size.height;
    screenWidth=size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children:<Widget>[
          menu(context),
          dashboard(context),
        ]
      ),
      
    );
  }

  Widget menu(context) {
    return Padding(
      padding:const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Text("Dashboard",
            style:TextStyle(color:Colors.white, fontSize:22)),
            Text("Profile",
            style:TextStyle(color:Colors.white, fontSize:22)),
            Text("Contests",
            style:TextStyle(color:Colors.white, fontSize:22)),
            Text("Achievements",
            style:TextStyle(color:Colors.white, fontSize:22)),
          ],
          
        ),
      ),
    );
    
  }

  Widget dashboard(context){
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0: 0.2 * screenHeight,
      bottom: isCollapsed ? 0: 0.2* screenWidth,
      left: isCollapsed ? 0: 0.6 * screenWidth,
      right:isCollapsed ? 0:  -0.4 * screenWidth,
        child: Material(
          animationDuration: duration,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        elevation: 8,
        color: backgroundColor,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top:48),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(child: Icon(Icons.menu, color: Colors.white),onTap: (){
                    setState(() {
                      isCollapsed=!isCollapsed;
                    });
                  }),
                  Text("My Classes", style: TextStyle(color:Colors.white, fontSize: 24)),
                  Icon(Icons.settings, color: Colors.white)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}