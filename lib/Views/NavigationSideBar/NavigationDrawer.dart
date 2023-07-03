import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/DonationView/DonateFoodView.dart';
import 'package:fyp/Views/SponsorView/SurplusFoodView.dart';
import 'package:fyp/Views/NgoView/ManageRequests.dart';
import 'package:fyp/Views/NgoView/NgoHomeView.dart';
import 'package:fyp/Views/NgoView/AddReport.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    NgoHomeView(),
    ManageRequests(),
    AddReport(),
    ProfilePage(),
    NgoHomeView(),
    ManageRequests(),
    SurplusFoodView(),

  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: GlobalColors.mainColor,
              borderRadius: BorderRadius.all(Radius.circular(3)),
              image: DecorationImage(
                scale: 1.5,
                image: AssetImage('assets/admin/SEF_white.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
            ),
          ),
          _buildNavigationItem(
            icon: Icons.home,
            title: 'Home',
            index: 0,
          ),
          SizedBox(height: 1), // Reduced space between title and entry
          ListTile(
            title: Text(
              'Requests',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(height: 1),

          _buildNavigationItem(
            icon: Icons.add_box_sharp,
            title: 'Manage Request',
            index: 1,
          ),
          SizedBox(height: 5), // Reduced space between title and entry
          ListTile(
            title: Text(
              'Reports',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          _buildNavigationItem(
            icon: Icons.add_box_sharp,
            title: 'Add Report',
            index: 2,
          ),
          _buildNavigationItem(
            icon: Icons.view_timeline,
            title: 'View Reports',
            index: 3,
          ),
          SizedBox(height: 5), // Reduced space between title and entry
          ListTile(
            title: Text(
              'Analytics',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          _buildNavigationItem(
            icon: Icons.view_timeline,
            title: 'View Analytics',
            index: 4,
          ),
          SizedBox(height: 5), // Reduced space between title and entry
          ListTile(
            title: Text(
              'Other',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildNavigationItem(
            icon: Icons.person,
            title: 'Profile',
            index: 5,
          ),
          _buildNavigationItem(
            icon: Icons.settings,
            title: 'Logout',
            index: 6,
          ),
          // SizedBox(height: 3), // Reduced space between last item and bottom edge
        ],
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return Container(
      margin: EdgeInsets.all(5),
      height: 50,
      color: _selectedIndex == index ? GlobalColors.greyColor.withOpacity(0.7) : null,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16), // Adjusted spacing
        leading: Icon(
          icon,
          color: _selectedIndex == index ? GlobalColors.titleHeading : null,
          // size: 15,
        ),
        title: Text(
          title,
          style: _selectedIndex == index
              ? TextStyle(color: GlobalColors.titleHeading, fontSize: 12)
              : TextStyle(color: Colors.black, fontSize: 12),
        ),
        onTap: () {
          _onTabSelected(index);
          // Navigator.pop(context);
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
