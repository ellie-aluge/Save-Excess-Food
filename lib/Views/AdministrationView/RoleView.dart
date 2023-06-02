import 'package:flutter/material.dart';
import 'package:fyp/utils/global.colors.dart';
import 'package:fyp/Views/AdministrationView/SignUpView.dart';

class RoleView extends StatefulWidget {
  const RoleView({Key? key}) : super(key: key);

  @override
  State<RoleView> createState() => _RoleViewState();
}

class _RoleViewState extends State<RoleView> {
  String? role;
  final List<String> _dropdownValues = [
    'NGO',
    'Delivery',
    'Sponsor',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 280.0,
                        decoration: BoxDecoration(
                          color: GlobalColors.mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          image: DecorationImage(
                            scale: 3.5,
                            image: AssetImage('assets/admin/SEF_white.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      top: 255,
                      child: Container(
                        height: 500.0,
                        width: 400,
                        decoration: BoxDecoration(
                          color: GlobalColors.containerField,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(15),
                              child: Text(
                                "What role would you be assuming on the Save Excess Food Application",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 300,
                              child: DropdownButtonFormField<String>(
                                value: role,
                                decoration: InputDecoration(
                                  labelText: 'Select a role',
                                  border: OutlineInputBorder(),
                                ),
                                items: _dropdownValues.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    role = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              width: 300,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: GlobalColors.titleHeading,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUpView(role: role),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'NEXT',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}