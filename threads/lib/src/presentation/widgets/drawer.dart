/**
 * @author [Frederic Chien]
 * @email [contato@kyuubi.com.br]
 * @create date 10-07-2023 10:16:03
 * @modify date 10-07-2023 10:16:03
 * @desc [description]
 */
import 'package:flutter/material.dart';
import 'package:threads/src/presentation/widgets/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onLogoutTap;
  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF2e3192),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //header
          Column(
            children: [
              DrawerHeader(
                child: Image.asset('assets/images/logo.png'),
              ),

              //menu list
              MyListTile(
                icon: Icons.home,
                text: "H O M E",
                onTap: () => Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.person,
                text: "P E R F I L",
                onTap: onProfileTap,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: "L O G O U T",
              onTap: onLogoutTap,
            ),
          ),
        ],
      ),
    );
  }
}
