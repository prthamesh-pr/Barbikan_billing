import 'package:flutter/material.dart';

class PartyTransactionView extends StatefulWidget {
  const PartyTransactionView({super.key});

  @override
  State<PartyTransactionView> createState() => _PartyTransactionViewState();
}

class _PartyTransactionViewState extends State<PartyTransactionView> {
  final List<Map<String, dynamic>> invoiceList = [
    {
      'sno': 1,
      'date': '2025-03-01',
      'billNumber': 'INV1001',
      'partyName': 'ABC Traders',
      'amount': '₹10,000',
    },
    {
      'sno': 2,
      'date': '2025-03-02',
      'billNumber': 'INV1002',
      'partyName': 'XYZ Distributors',
      'amount': '₹15,500',
    },
    {
      'sno': 3,
      'date': '2025-03-03',
      'billNumber': 'INV1003',
      'partyName': 'LMN Suppliers',
      'amount': '₹8,750',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get device dimensions to calculate responsive sizes
        final width = constraints.maxWidth;

        // Calculate responsive sizes
        final headerFontSize = _getResponsiveSize(width, 18, 16, 14);
        final bodyFontSize = _getResponsiveSize(width, 16, 14, 12);
        final iconSize = _getResponsiveSize(width, 24, 20, 18);
        final padding = _getResponsiveSize(width, 16, 12, 8);

        return Column(
          children: [
            // Header with Add Transaction button
            Padding(
              padding: EdgeInsets.all(padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction List',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Table section
            Expanded(
              child:
                  width < 600
                      ? _buildCardView(bodyFontSize, iconSize, padding)
                      : _buildTableView(
                        width,
                        headerFontSize,
                        bodyFontSize,
                        iconSize,
                        padding,
                      ),
            ),
          ],
        );
      },
    );
  }

  // Table layout for medium and large screens
  Widget _buildTableView(
    double width,
    double headerFontSize,
    double bodyFontSize,
    double iconSize,
    double padding,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: width < 800 ? 800 : width, // Prevent squishing on medium screens
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: DataTable(
              columnSpacing: padding,
              headingRowHeight: 56,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 52,
              columns: [
                DataColumn(
                  label: Text(
                    'S.NO',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Bill Number',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Party Name',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: TextStyle(
                      fontSize: headerFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows:
                  invoiceList.map((invoice) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            invoice['sno'].toString(),
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            invoice['date'],
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            invoice['billNumber'],
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            invoice['partyName'],
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
                        ),
                        DataCell(
                          Text(
                            invoice['amount'],
                            style: TextStyle(fontSize: bodyFontSize),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.visibility, size: iconSize),
                                onPressed: () {},
                                tooltip: 'View',
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, size: iconSize),
                                onPressed: () {},
                                tooltip: 'Edit',
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, size: iconSize),
                                onPressed: () {},
                                tooltip: 'Delete',
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
      ),
    );
  }

  // Card layout for small screens (mobile)
  Widget _buildCardView(double fontSize, double iconSize, double padding) {
    return ListView.builder(
      itemCount: invoiceList.length,
      padding: EdgeInsets.all(padding),
      itemBuilder: (context, index) {
        final invoice = invoiceList[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.only(bottom: padding),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bill #${invoice['billNumber']}',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      invoice['amount'],
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding / 2),
                Text(
                  'Date: ${invoice['date']}',
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  'Party: ${invoice['partyName']}',
                  style: TextStyle(fontSize: fontSize),
                ),
                SizedBox(height: padding / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.visibility, size: iconSize),
                      onPressed: () {},
                      tooltip: 'View',
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: iconSize),
                      onPressed: () {},
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, size: iconSize),
                      onPressed: () {},
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to calculate responsive sizes
  double _getResponsiveSize(
    double width,
    double large,
    double medium,
    double small,
  ) {
    if (width > 1200) {
      return large;
    } else if (width > 600) {
      return medium;
    } else {
      return small;
    }
  }
}
