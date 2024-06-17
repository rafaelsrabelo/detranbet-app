import 'package:detranbet/screens/historic_page.dart';
import 'package:detranbet/screens/home_page.dart';
import 'package:detranbet/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            currentPage = value;
          });
        }),
        children: const <Widget>[HomePage(), HistoricPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Config.backgroundColor,
        currentIndex: currentPage,
        onTap: (page) {
          _page.animateToPage(page,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Apostas Realizadas',
          ),
        ],
      ),
    );
  }
}
