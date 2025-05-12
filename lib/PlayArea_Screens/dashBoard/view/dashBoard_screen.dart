import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewModel/PlayArea_dashBoard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with OnInit{

  String formatNumber(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: "",
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width<600 ?
     Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate a base size factor for all text
          double textScaleFactor = constraints.maxWidth / 1400;
          // Clamp the scale factor to prevent too small or too large text
          textScaleFactor = textScaleFactor.clamp(0.7, 1.2);

          // Determine if we're on a small screen (mobile)
          bool isSmallScreen = constraints.maxWidth < 600;

          return Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                  ),
                ),
                const SizedBox(height: 15),

                // Responsive layout based on screen width
                if (isSmallScreen)
                  _buildMobileLayout(constraints)
                // else
                //   _buildDesktopLayout(constraints),
              ],
            ),
          );
        },
      ),
    ):
    Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate a base size factor for all text
          double textScaleFactor = constraints.maxWidth / 1400;
          // Clamp the scale factor to prevent too small or too large text
          textScaleFactor = textScaleFactor.clamp(0.7, 1.2);

          // Determine if we're on a small screen (mobile)
          bool isSmallScreen = constraints.maxWidth < 600;

          return Container(
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                  ),
                ),
                const SizedBox(height: 15),

                // Responsive layout based on screen width
                if (isSmallScreen)
                  _buildMobileLayout(constraints)
                // else
                //   _buildDesktopLayout(constraints),
              ],
            ),
          );
        },
      ),
    );
  }

  // Mobile layout with cards stacked in rows of two
  Widget _buildMobileLayout(BoxConstraints constraints) {
    // Calculate dynamic aspect ratio for smaller screens
    double cardAspectRatio = constraints.maxWidth < 600 ? (1 / 0.6) : (1 / 0.5);

    return Consumer<PlayAreaDashBoardProvider>(
        builder: (context, controller, child) {
          final stats = controller.stats;
          final bookings = controller.listOfGamesData;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GridView(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: cardAspectRatio,
                ),
                children: [
                  cardView(
                    title: "Football",
                    value:(stats?.football ?? 0).toString(),

                    footer: "Total Booking today",
                    color: Colors.green,
                    constraints: constraints,
                  ),
                  cardView(
                    title: "Cricket",
                    value:  (stats?.cricket ?? 0).toString(),

                    footer: "Total Booking today",
                    color: Colors.redAccent,
                    constraints: constraints,
                  ),
                ],
              ),


              // Second row: Today Sales and Products
              GridView(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: cardAspectRatio,
                ),
                children: [
                  cardView(
                    title: "Badminton",
                    value: (stats?.badminton ?? 0).toString(),
                    footer: "Total Booking today",
                    color: Colors.blueAccent,
                    constraints: constraints,
                  ),
                  cardView(
                    title: "Table Tennis",
                    value: (stats?.tableTennis ?? 0).toString(),
                    footer: "Total Booking today",
                    color: Colors.orangeAccent,
                    constraints: constraints,
                  ),
                ],
              ),

              const SizedBox(height: 10),
              // First row: Sales and Purchase

            SizedBox(height: 40),
              // Low Stock Products below

              Text('All-time bookings across all turfs',
                style: TextStyle(fontSize: 15,color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.listOfGamesData.length,
                    itemBuilder: (context, index){
                      final user = controller.listOfGamesData[index];
                      return  Card(
                        color: Colors.white,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // S.NO and Category Name
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.turf!.sport!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                         user.turf!.name!,
                                          // 'Category: ${user.categoryName}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),

                                        // Text(
                                        //  user.userEmail!,
                                        //   // 'Category: ${user.categoryName}',
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w500,
                                        //     fontSize: 14,
                                        //   ),
                                        //   overflow: TextOverflow.visible,
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // No. of Products
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.userName!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                         user.userPhone!,
                                          //'${user.noOfProducts}',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 4),
                                        // Text(
                                        //   user.userPhone!,
                                        //   //'${user.noOfProducts}',
                                        //   style: TextStyle(fontSize: 14),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                       'Timing',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            formatTime(user.startTime!),
                                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(width: 5),
                                          Text('-'),
                                          SizedBox(width: 5),
                                          Text(
                                            formatTime(user.endTime!),
                                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 4),
                                  SizedBox(height: 10),

                                ],
                              ),

                              // Active status and Action buttons
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //
                              //     GestureDetector(
                              //       onTapDown: (TapDownDetails details) async {
                              //         final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                              //
                              //         final value = await showMenu(
                              //           context: context,
                              //           position: RelativeRect.fromRect(
                              //             details.globalPosition & const Size(40, 40),
                              //             Offset.zero & overlay.size,
                              //           ),
                              //
                              //           color: Colors.white,
                              //           items: [
                              //             PopupMenuItem(
                              //               value: 'edit',
                              //               child: Row(
                              //                 children: const [
                              //                   Icon(Icons.edit, color: Colors.black),
                              //                   SizedBox(width: 8),
                              //                   Text('Edit'),
                              //                 ],
                              //               ),
                              //             ),
                              //             PopupMenuItem(
                              //               value: 'delete',
                              //               child: Row(
                              //                 children: const [
                              //                   Icon(Icons.delete, color: Colors.black),
                              //                   SizedBox(width: 8),
                              //                   Text('Delete'),
                              //                 ],
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //
                              //         if (value == 'edit') {
                              //           // Handle Edit
                              //           print('Edit Clicked');
                              //         } else if (value == 'delete') {
                              //
                              //           bool confirmDelete = await showDialog(
                              //             context: context,
                              //             builder: (context) => AlertDialog(
                              //               backgroundColor: Colors.white,
                              //
                              //               title: Text('Confirm Delete'),
                              //               content: Text('Are you sure you want to delete this company?'),
                              //               actions: [
                              //                 TextButton(
                              //                   onPressed: () => Navigator.pop(context, false),
                              //                   child: Text('Cancel'),
                              //                 ),
                              //                 TextButton(
                              //                   onPressed: () => Navigator.pop(context, true),
                              //                   child: Text('Delete', style: TextStyle(color: Colors.red)),
                              //                 ),
                              //               ],
                              //             ),
                              //           );
                              //
                              //           if (confirmDelete == true) {
                              //             // print("user.id!===${user.id!}");
                              //            // await controller.deleteCategory(user.id!);
                              //             //controller.deleteUsers(user.id!);
                              //
                              //           }
                              //         }
                              //       },
                              //       child: Icon(Icons.more_horiz),
                              //     )
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      );
                    })
              ),
            ],
          );
        }
    );
  }

  // Desktop layout
  // Widget _buildDesktopLayout(BoxConstraints constraints) {
  //   return Consumer<PlayAreaDashBoardProvider>(
  //       builder: (context, controller, child) {
  //         return SizedBox(
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 flex: 2,
  //                 child: GridView(
  //                   primary: false,
  //                   shrinkWrap: true,
  //                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                     crossAxisCount: 2,
  //                     mainAxisSpacing: 10,
  //                     crossAxisSpacing: 10,
  //                     childAspectRatio: (1 / 0.4),
  //                   ),
  //                   children: [
  //                     cardView(
  //                       title: "Sales",
  //                       value: formatNumber(10000),
  //                       footer: "This Month Sales",
  //                       color: Colors.green,
  //                       constraints: constraints,
  //                     ),
  //                     cardView(
  //                       title: "Purchase",
  //                       value: formatNumber(500000),
  //                       footer: "This Month Purchase",
  //                       color: Colors.redAccent,
  //                       constraints: constraints,
  //                     ),
  //                     cardView(
  //                       title: "Today Sales",
  //                       value: formatNumber(50000),
  //                       footer: "Today Over all Sales",
  //                       color: Colors.blueAccent,
  //                       constraints: constraints,
  //                     ),
  //                     cardView(
  //                       title: "Products",
  //                       value: formatNumber(50),
  //                       footer: "Total No of Products",
  //                       color: Colors.orangeAccent,
  //                       constraints: constraints,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const SizedBox(width: 10),
  //               Expanded(
  //                 child: Container(
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: Column(
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.all(10.0),
  //                         child: FittedBox(
  //                           fit: BoxFit.scaleDown,
  //                           child: Text(
  //                             "Low Stock Products",
  //                             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: double.infinity,
  //                         child: DataTable(
  //                           columnSpacing: 10.0,
  //                           columns: [
  //                             DataColumn(
  //                               label: SizedBox(
  //                                 width: 130,
  //                                 child: FittedBox(
  //                                   fit: BoxFit.scaleDown,
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(
  //                                     'Product Name',
  //                                     style: TextStyle(fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             DataColumn(
  //                               label: SizedBox(
  //                                 width: 90,
  //                                 child: FittedBox(
  //                                   fit: BoxFit.scaleDown,
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(
  //                                     'Current Stock',
  //                                     style: TextStyle(fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             DataColumn(
  //                               label: SizedBox(
  //                                 width: 100,
  //                                 child: FittedBox(
  //                                   fit: BoxFit.scaleDown,
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Text(
  //                                     'Minimum Stock',
  //                                     style: TextStyle(fontWeight: FontWeight.bold),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                           rows:
  //                           controller.dashBoardList.map((product) {
  //                             return DataRow(
  //                               cells: [
  //                                 DataCell(
  //                                   FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     alignment: Alignment.centerLeft,
  //                                     child: Text(product.productName!),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     alignment: Alignment.centerLeft,
  //                                     child: Text(
  //                                       product.openingStock!.toString(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 DataCell(
  //                                   FittedBox(
  //                                     fit: BoxFit.scaleDown,
  //                                     alignment: Alignment.centerLeft,
  //                                     child: Text(
  //                                       product.minStock.toString(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           }).toList(),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       }
  //   );
  // }

  Widget cardView({
    required String title,
    required String value,
    required String footer,
    required Color color,
    required BoxConstraints constraints,
  }) {
    double cardPadding = constraints.maxWidth < 600 ? 12.0 : 16.0;
    double spacingHeight = 6.0;

    double titleSize = constraints.maxWidth < 600 ? 14.0 : 16.0;
    double valueSize = constraints.maxWidth < 600 ? 18.0 : 24.0;
    double footerSize = constraints.maxWidth < 600 ? 10.0 : 14.0;

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3), // background tint
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // left-align text
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              decoration: TextDecoration.none,
              // no underline
            ),
          ),
          SizedBox(height: spacingHeight),
          Text(
            value,
            style: TextStyle(
              fontSize: valueSize,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: spacingHeight),
          Text(
            footer,
            style: TextStyle(
              fontSize: footerSize,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(String time) {
    try {
      final parsed = DateFormat('HH:mm:ss').parse(time);
      return DateFormat('h:mm').format(parsed); // for 12-hour format
      // return DateFormat('HH:mm').format(parsed); // for 24-hour format
    } catch (e) {
      return time;
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<PlayAreaDashBoardProvider>(context,listen: false).initState();
  }

}
