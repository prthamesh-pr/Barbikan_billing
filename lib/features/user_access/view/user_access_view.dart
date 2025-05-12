
import 'package:billing_web/features/user_access/view/create_user_view.dart';
import 'package:billing_web/features/user_access/viewModel/userAccess_provider.dart';
import 'package:flutter/material.dart';
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
        builder: (context) => const CreateNewUser(),
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

  Widget _buildMobileList(BuildContext context) {
    return Consumer<UserAccessProvider>(
        builder: (context, controller, child) {
          return Column(
              children:[
                ListView.builder(
                  //  controller: listScrollController,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:controller.userAccessList.length,
                    itemBuilder: (context, index){
                      final user = controller.userAccessList[index];
                      return  Card(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'S.NO:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      '#${index + 1}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              _buildRow('Name:', user.username ?? ''),
                              _buildRow('Role:', user.accountType == 'admin' ? 'Admin' : 'Staff'),
                              _buildRow('Mobile No.:', user.mobileNumber ?? ''),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    GestureDetector(
                                      onTapDown: (TapDownDetails details) async {
                                        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                                        final value = await showMenu(
                                          context: context,
                                          position: RelativeRect.fromRect(
                                            details.globalPosition & const Size(40, 40),
                                            Offset.zero & overlay.size,
                                          ),

                                          color: Colors.white,
                                          items: [
                                            PopupMenuItem(
                                              value: 'edit',
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.edit, color: Colors.black),
                                                  SizedBox(width: 8),
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem(
                                              value: 'delete',
                                              child: Row(
                                                children: const [
                                                  Icon(Icons.delete, color: Colors.black),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );

                                        if (value == 'edit') {
                                          // Handle Edit
                                          print('Edit Clicked');
                                          controller.loadUserData(user);
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                              builder: (context) => EditUserView()));
                                        } else if (value == 'delete') {

                                          bool confirmDelete = await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.white,

                                              title: Text('Confirm Delete'),
                                              content: Text('Are you sure you want to delete this company?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context, true),
                                                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                                                ),
                                              ],
                                            ),
                                          );

                                          if (confirmDelete == true) {
                                            print("user.id!===${user.id!}");
                                            await controller.deleteUsers(user.id!);

                                          }
                                        }
                                      },
                                      child: Icon(Icons.more_horiz),
                                    )
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                    }
                )
              ]
          );
        }
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(label, style: TextStyle( color: Colors.grey[600],fontSize: 16)),
          Text(value, style: TextStyle( fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
  Widget _buildDataTable(BuildContext context, BoxConstraints constraints, bool isSmallScreen) {
    return Consumer<UserAccessProvider>(
      builder: (context, controller, child) {
        return
          controller.isLoading?Center(
              child: CircularProgressIndicator(
            color: Colors.orange,
          )):
          Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: _buildMobileList(context),

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