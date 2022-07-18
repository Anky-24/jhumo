import 'package:flutter/material.dart';
import 'package:jhumo/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:jhumo/providers/providers.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (idx) {
        var pages =
            Provider.of<NavTabProvider>(context, listen: false).loadedPages;
        if (!pages.contains(idx)) {
          pages.add(idx);
        }
        Provider.of<NavTabProvider>(context, listen: false)
            .setLoadedPages(pages);
        Provider.of<NavTabProvider>(context, listen: false).setTab(idx);
      },
      currentIndex: Provider.of<NavTabProvider>(context).tabIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: bNavBarL,
      elevation: 0.0,
      selectedItemColor: selNavItemL,
      unselectedItemColor: unSelNavItemL,
      iconSize: 30,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(
            Icons.headphones,
          ),
        ),
        BottomNavigationBarItem(
          label: "Contest",
          icon: Icon(
            Icons.leaderboard,
          ),
        ),
        BottomNavigationBarItem(
          label: "Schedule",
          icon: Icon(
            Icons.schedule,
          ),
        ),
        BottomNavigationBarItem(
          label: "Contact Us",
          icon: Icon(
            Icons.call,
          ),
        ),
      ],
    );
  }
}
