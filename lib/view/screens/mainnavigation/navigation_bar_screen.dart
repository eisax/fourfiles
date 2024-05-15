import 'package:flutter/material.dart';
import 'package:fourfiles/view/screens/create/create_file_screen.dart';
import 'package:fourfiles/view/screens/docs/docs_screen.dart';
import 'package:fourfiles/view/screens/favourite/favourite_screen.dart';
import 'package:fourfiles/view/screens/home/home_screen.dart';
import 'package:fourfiles/view/screens/more/more_screen.dart';
import 'package:get/get.dart';
import 'package:fourfiles/util/dimensiona.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const DocsScreen(),
    const FavoriteScreen(),
    const MoreScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 10.0,
        shadowColor:Theme.of(context).shadowColor,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildBottomNavItem(0, Icons.home, "Home", context),
            buildBottomNavItem(1, Icons.edit_document, "Documents", context),
            Container(),
            buildBottomNavItem(2, Icons.favorite, "Favourite", context),
            buildBottomNavItem(3, Icons.more_horiz, "More", context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateFileScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4.0,
        splashColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(
          side: BorderSide(
            width: 2,
            color: Colors.white
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomNavItem(
      int index, IconData icon, String title, BuildContext context) {
    return AnimatedAlign(
      duration: const Duration(milliseconds: 1000),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: _selectedIndex == index
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                ),
                SizedBox(
                  height: Dimensions.paddingSizeExtraSmall,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: _selectedIndex == index
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBottomCenterNavItem(IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateFileScreen()),
        );
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
