import 'package:flutter/material.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/layout/default_layout.dart';
import 'package:section2/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
    );

    //tab이 변경될 때 마다 실행
    tabController.addListener(() {
      tabListener();
    });
  }

  //tab이 변경될 때 마다 실행
  void tabListener() {
    setState(() {
      this.tabIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          RestaurantScreen(),
          Center(
            child: Container(
              child: Text('음식'),
            ),
          ),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          Center(
            child: Container(
              child: Text('프로필'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          tabController.animateTo(index);

          setState(() {});
        },
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
