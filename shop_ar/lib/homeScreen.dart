import 'package:flutter/material.dart';
import 'package:shop_ar/screens/home/homeScreen.dart';
import 'package:shop_ar/buttomNavigationPages/profilePage/profile.dart';
import 'package:shop_ar/screens/product/shopping_cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int page) {
    setState(() {
      _selectedIndex = page;
    });
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(

          title: const Text('ShopAR',
            style: TextStyle(color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold
            ),),
          centerTitle: true,
          //backgroundColor: Color(0xFFE84855),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Cart()),
                    );
                  }
              ),
            )
          ],
        ),
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const Home(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xffF08B93),
          onTap: onTapped),
    );
  }
}
