import 'package:billing_web/features/party/purchase_party/viewModel/purchaseParty_list_provider.dart';
import 'package:billing_web/features/purchase_list/view/purchase_edit_view.dart';
import 'package:billing_web/features/purchase_list/viewModel/purchaseBill_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/on_init.dart';
import 'purchase_create_view.dart';

class PurchaseListView extends StatefulWidget {
  const PurchaseListView({super.key});

  @override
  State<PurchaseListView> createState() => _PurchaseListViewState();
}

class _PurchaseListViewState extends State<PurchaseListView> with OnInit{
  // final List<Map<String, dynamic>> purchaseList = [
  //   {
  //     'sno': 1,
  //     'date': '2025-03-01',
  //     'billNumber': 'PUR1001',
  //     'partyName': 'ABC Traders',
  //     'amount': '₹20,000',
  //   },
  //   {
  //     'sno': 2,
  //     'date': '2025-03-02',
  //     'billNumber': 'PUR1002',
  //     'partyName': 'XYZ Distributors',
  //     'amount': '₹12,500',
  //   },
  //   {
  //     'sno': 3,
  //     'date': '2025-03-03',
  //     'billNumber': 'PUR1003',
  //     'partyName': 'LMN Suppliers',
  //     'amount': '₹18,750',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return ListView(
      padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
      children: [
        // Header section
        SizedBox(
          width: double.infinity,
          child:
              isSmallScreen
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase List",
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              fontSize: screenWidth < 400 ? 18 : null,
                            ),
                          ),
                          Text(
                            "Manage and features all purchases",
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium?.copyWith(
                              fontSize: screenWidth < 400 ? 12 : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      _buildAddButton(context, isSmallScreen),
                    ],
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase List",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            "Manage and features all purchases",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                      _buildAddButton(context, isSmallScreen),
                    ],
                  ),
        ),

        SizedBox(height: 15),

        // Data table section
        Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child:
              isSmallScreen ? _buildMobileDataView() : _buildDesktopDataTable(),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context, bool isSmallScreen) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 360;

    return InkWell(
      onTap: () async {
       // final provider = Provider.of<PurchasePartyListProvider>(context, listen: false);

        print('object=========');
      //  await provider.getPurchaseParty();
        // Add haptic feedback for mobile devices
        HapticFeedback.lightImpact();

        // Navigate to purchase_list create features
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PurchaseCreateView(),
            fullscreenDialog: isSmallScreen, // Full screen on mobile
          ),
        ).then((value) {
          // Refresh data when returning if needed
          if (value == true) {
            setState(() {
              // Refresh purchase_list list
            });
          }
        });
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isVerySmallScreen ? 10 : 15,
          vertical:
              isSmallScreen ? 8 : 10, // Slightly larger touch target for mobile
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor,
          // Add shadow for better visibility on mobile
          boxShadow:
              isSmallScreen
                  ? [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: isSmallScreen ? 16 : 20),
            SizedBox(width: isVerySmallScreen ? 5 : 10),
            Text(
              isVerySmallScreen
                  ? "Add"
                  : isSmallScreen
                  ? "Add New"
                  : "Add New Purchase",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDataTable() {
    // Keep desktop features exactly as it was
    final provider = Provider.of<PurchaseListProvider>(context);
    final categoryList = provider.listOfPurchaseBill;
    return DataTable(
      columnSpacing: 20.0,
      columns: [
        DataColumn(label: Text('S.NO')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Bill Number')),
        DataColumn(label: Text('Party Name')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Action')),
      ],
      rows:
      List.generate(categoryList.length, (index) {
        final purchase = categoryList[index];
            return DataRow(
              cells: [
                DataCell(Text('S.NO:${index +1}')),

                DataCell(Text(purchase.billDate!)),
                DataCell(Text(purchase.billNumber!)),
                DataCell(Text(purchase.purchaseParty!.partyName!)),
                DataCell(Text(purchase.grandTotal!)),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Iconsax.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Iconsax.trash),
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
    );
  }

  Widget _buildMobileDataView() {
    return Consumer<PurchaseListProvider>(
      builder: (context, controller, child) {
        return Column(
          children: [ ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.listOfPurchaseBill.length,
              itemBuilder: (context, index){
                final user = controller.listOfPurchaseBill[index];
                return Card(
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
                            // S.NO and Bill Number
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'S.NO:${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Bill: ${user.billNumber}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Date
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,

                                  children: [
                                    Text(
                                      'Date:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                        DateFormat('yyyy-MM-dd').format(DateTime.parse(user.billDate!)),
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // Party Name and Amount
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Party Name
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Party Name:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    user.partyName!,
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                            // Amount
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Amount:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${user.grandTotal}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // Action buttons
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                                            builder: (context) => PurchaseEditView()));
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
                                      // print("user.id!===${user.id!}");
                                        await controller.deletePurchasebill(user.id!);


                                    }
                                  }
                                },
                                child: Icon(Icons.more_horiz),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
         ]
        );
      }
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<PurchaseListProvider>(context,listen: false).initState();
  }
}
