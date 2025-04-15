import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/services.dart';

import 'purchase_create_view.dart';

class PurchaseListView extends StatefulWidget {
  const PurchaseListView({super.key});

  @override
  State<PurchaseListView> createState() => _PurchaseListViewState();
}

class _PurchaseListViewState extends State<PurchaseListView> {
  final List<Map<String, dynamic>> purchaseList = [
    {
      'sno': 1,
      'date': '2025-03-01',
      'billNumber': 'PUR1001',
      'partyName': 'ABC Traders',
      'amount': '₹20,000',
    },
    {
      'sno': 2,
      'date': '2025-03-02',
      'billNumber': 'PUR1002',
      'partyName': 'XYZ Distributors',
      'amount': '₹12,500',
    },
    {
      'sno': 3,
      'date': '2025-03-03',
      'billNumber': 'PUR1003',
      'partyName': 'LMN Suppliers',
      'amount': '₹18,750',
    },
  ];

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
                            "Manage and view all purchases",
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
                            "Manage and view all purchases",
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
            color: Colors.white,
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
      onTap: () {
        // Add haptic feedback for mobile devices
        HapticFeedback.lightImpact();

        // Navigate to purchase create view
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
              // Refresh purchase list
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
    // Keep desktop view exactly as it was
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
          purchaseList.map((purchase) {
            return DataRow(
              cells: [
                DataCell(Text(purchase['sno'].toString())),
                DataCell(Text(purchase['date'])),
                DataCell(Text(purchase['billNumber'])),
                DataCell(Text(purchase['partyName'])),
                DataCell(Text(purchase['amount'])),
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
    return Column(
      children:
          purchaseList.map((purchase) {
            return Card(
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
                                'S.NO: ${purchase['sno']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Bill: ${purchase['billNumber']}',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${purchase['date']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
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
                                '${purchase['partyName']}',
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${purchase['amount']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            minimumSize: Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Iconsax.edit, size: 16),
                          label: Text('Edit', style: TextStyle(fontSize: 12)),
                          onPressed: () {
                            // Handle edit action
                          },
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            minimumSize: Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Iconsax.trash, size: 16),
                          label: Text('Delete', style: TextStyle(fontSize: 12)),
                          onPressed: () {
                            // Handle delete action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
