import 'package:barbikan/view/user_access/create_user_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserAndAccessView extends StatefulWidget {
  const UserAndAccessView({super.key});

  @override
  State<UserAndAccessView> createState() => _UserAndAccessViewState();
}

class _UserAndAccessViewState extends State<UserAndAccessView> {
  final List<Map<String, dynamic>> staffList = [
    {'sno': 1, 'name': 'John Doe', 'role': 'Admin', 'mobile': '9876543210'},
    {'sno': 2, 'name': 'Jane Smith', 'role': 'Staff', 'mobile': '9876543211'},
    {'sno': 3, 'name': 'Mark Taylor', 'role': 'Admin', 'mobile': '9876543212'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a small screen
        final isSmallScreen = constraints.maxWidth < 600;

        return ListView(
          padding: EdgeInsets.all(isSmallScreen ? 8.0 : 15.0),
          children: [
            _buildHeader(context, isSmallScreen),
            SizedBox(height: isSmallScreen ? 10 : 15),
            _buildDataTable(context, constraints, isSmallScreen),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    final headerWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "User and Access",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: isSmallScreen ? 20 : null,
          ),
        ),
        Text(
          "Manage and collaborate within your organization's teams",
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );

    final createButton = GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CreateNewUserView()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 10 : 15,
          vertical: isSmallScreen ? 6 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: isSmallScreen ? 16 : 20),
            SizedBox(width: isSmallScreen ? 5 : 10),
            Text(
              isSmallScreen ? "New User" : "Create New User",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );

    // Layout differently based on screen size
    if (isSmallScreen) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [headerWidget, SizedBox(height: 10), createButton],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [headerWidget, createButton],
      );
    }
  }

  Widget _buildDataTable(
    BuildContext context,
    BoxConstraints constraints,
    bool isSmallScreen,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: constraints.maxWidth - (isSmallScreen ? 16 : 30),
          ),
          child: DataTable(
            columnSpacing: isSmallScreen ? 10.0 : 20.0,
            horizontalMargin: isSmallScreen ? 10.0 : 20.0,
            headingTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 12 : 14,
            ),
            dataTextStyle: TextStyle(fontSize: isSmallScreen ? 11 : 13),
            columns: [
              DataColumn(label: Text('S.NO')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Role')),
              DataColumn(label: Text('Mobile Number')),
              DataColumn(label: Text('Action')),
            ],
            rows:
                staffList.map((staff) {
                  return DataRow(
                    cells: [
                      DataCell(Text(staff['sno'].toString())),
                      DataCell(Text(staff['name'])),
                      DataCell(Text(staff['role'])),
                      DataCell(Text(staff['mobile'])),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(
                                Iconsax.edit,
                                size: isSmallScreen ? 16 : 20,
                              ),
                              padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                // Handle edit action
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(
                                Iconsax.trash,
                                size: isSmallScreen ? 16 : 20,
                              ),
                              padding: EdgeInsets.all(isSmallScreen ? 4 : 8),
                              constraints: BoxConstraints(),
                              onPressed: () {
                                // Handle delete action
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
