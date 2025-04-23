
import 'package:billing_web/features/user_access/view/create_user_view.dart';
import 'package:billing_web/features/user_access/viewModel/userAccess_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../utils/Strings.dart';
import '../../utils/on_init.dart';
import 'edit_user_view.dart';

class UserAndAccessView extends StatefulWidget {
  const UserAndAccessView({super.key});

  @override
  State<UserAndAccessView> createState() => _UserAndAccessViewState();
}

class _UserAndAccessViewState extends State<UserAndAccessView> with OnInit{
  // final List<Map<String, dynamic>> staffList = [
  //   {'sno': 1, 'name': 'John Doe', 'role': 'Admin', 'mobile': '9876543210'},
  //   {'sno': 2, 'name': 'Jane Smith', 'role': 'Staff', 'mobile': '9876543211'},
  //   {'sno': 3, 'name': 'Mark Taylor', 'role': 'Admin', 'mobile': '9876543212'},
  // ];
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UserAccessProvider>(
      builder: (context, controller,child) {
        return

          LayoutBuilder(
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
    );
  }

  Widget _buildHeader(BuildContext context, bool isSmallScreen) {
    final headerWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.userAccess,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: isSmallScreen ? 20 : null,
          ),
        ),
        Text(Strings.orgTeam,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );

    final createButton = GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateNewUserView(),
      ),
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
        children: [
          headerWidget,
          SizedBox(height: 10),
          createButton,
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerWidget,
          createButton,
        ],
      );
    }
  }

  Widget _buildDataTable(BuildContext context, BoxConstraints constraints, bool isSmallScreen) {
    return Consumer<UserAccessProvider>(
      builder: (context, controller, child) {
        return
          controller.isLoading?Center(child: CircularProgressIndicator(
            color: Colors.orange,

          )):
          Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth - (isSmallScreen ? 16 : 30)),
              child: DataTable(
                columnSpacing: isSmallScreen ? 10.0 : 20.0,
                horizontalMargin: isSmallScreen ? 10.0 : 20.0,
                headingTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isSmallScreen ? 12 : 14,
                ),
                dataTextStyle: TextStyle(
                  fontSize: isSmallScreen ? 11 : 13,
                ),
                columns: [
                  DataColumn(label: Text('S.NO')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Mobile Number')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.userAccessList.asMap().entries.map((entry) {
                  int index = entry.key;
                 var staff = entry.value;

                  return DataRow(
                    cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(Text(staff.username??""
                          )),
                      DataCell(Text(staff.accountType ?? '')),
                      DataCell(Text(staff.mobileNumber ?? '')),

                      //  DataCell(Text(controller.userAccessList[index].)),
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              color: Colors.blue,
                              icon: Icon(Iconsax.edit, size: isSmallScreen ? 16 : 20),
                              onPressed: () {
                                controller.loadUserData(staff);
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditUserView(),
                                    ));
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Iconsax.trash, size: isSmallScreen ? 16 : 20),
                              onPressed: () {
                                // Handle delete
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
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<UserAccessProvider>(context,listen: false).initState();
  }



}