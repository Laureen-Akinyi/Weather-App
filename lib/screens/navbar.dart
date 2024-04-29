import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:  [
          const UserAccountsDrawerHeader(
            accountName: Text('Keith Ebony'),
            accountEmail: Text('keithebo@gmail.com'),
            currentAccountPicture: CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage('assets/images/sea_rainy.png'),
            ),
            decoration: BoxDecoration(color: Color.fromARGB(255, 141, 219, 144)),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text('Favorites'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.update_sharp),
            title: const Text('Updates'),
            onTap: () => print('new update'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => print('new notification'),
          ),
        ],
      ),
    );
  }
}
