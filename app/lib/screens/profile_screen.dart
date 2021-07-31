import 'package:flutter/material.dart';
import '../constants/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(
                        "assets/images/16.jpg",
                      ),
                    ),
                  ),

                  Text(
                    'Crm Admistratora',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        size: 40.0,
                        color: Colors.black,
                      ),
                      title: Text(
                        'Dashboard',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  DrawerListTile('Categories', 0, Icons.list_alt),
                  DrawerListTile('Products', 4, Icons.shop),
                  DrawerListTile('Product Catalog', 4,
                      Icons.production_quantity_limits_sharp),
                  DrawerExpansionTile(
                    'Orders',
                    [
                      ExapandedListItem('Sales Report', () {}),
                      ExapandedListItem('Collection Report', () {}),
                      ExapandedListItem('Order by debt', () {}),
                      ExapandedListItem('Customer by debt', () {}),
                    ],
                    4,
                    Icons.shopping_bag,
                  ),
                  DrawerExpansionTile(
                    'Client Management',
                    [
                      ExapandedListItem('Clients', () {}),
                      ExapandedListItem('Invoices', () {}),
                      ExapandedListItem('Add Money', () {}),
                    ],
                    4,
                    Icons.handyman,
                  ),
                  DrawerExpansionTile(
                      'User Management',
                      [
                        ExapandedListItem('Users', () {}),
                        ExapandedListItem('Roles', () {}),
                      ],
                      4,
                      Icons.supervised_user_circle_sharp),
                  DrawerExpansionTile(
                      'Master',
                      [
                        ExapandedListItem('Countries', () {}),
                        ExapandedListItem('States', () {}),
                      ],
                      0,
                      Icons.folder_open_outlined)

                  // DrawerHeader(child: )
                ],
              ),
            ),
          ),
          Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width * 3.1 / 4,
            child: ListTile(
              tileColor: primaryDark,
              leading: Icon(
                Icons.logout,
                color: Colors.white,
                size: 20.0,
              ),
              title: Text(
                'Sign out',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile DrawerListTile(
    String title,
    int count,
    IconData data,
  ) {
    Text text = Text(
      // '',
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
    return ListTile(
        leading: Icon(
          data,
          size: 35.0,
          color: Colors.white,
        ),
        title: count > 0
            ? Row(
                children: [
                  text,
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10,
                    child: Text(
                      '$count',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              )
            : text);
  }

  ExpansionTile DrawerExpansionTile(
    String title,
    List<Widget> items,
    int count,
    IconData data,
  ) {
    Text text = Text(
      // 'Master',
      title,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      ),
    );
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      iconColor: Colors.white,
      // collapsedBackgroundColor: Colors.white,
      collapsedIconColor: Colors.white,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      leading: Icon(
        data,
        size: 30.0,
        color: Colors.white,
      ),
      title: (count > 0)
          ? Row(
              children: [
                text,
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
          : text,
      // children: [
      //   ExapandedListItem('Countries', () {}),
      //   ExapandedListItem('States', () {}),
      // ],
      children: items,
    );
  }

  GestureDetector ExapandedListItem(
    String title,
    Function onTap,
  ) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: EdgeInsets.only(left: 70.0),
        margin: EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
