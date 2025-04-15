import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String formatNumber(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: "",
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  final List<Map<String, dynamic>> products = [
    {
      'product_name': 'Coffee Beans Not Roasted',
      'current_stock': 10,
      'minimum_stock': 3,
    },
    {'product_name': 'Laptop', 'current_stock': 10, 'minimum_stock': 3},
    {'product_name': 'Mobile', 'current_stock': 15, 'minimum_stock': 5},
    {'product_name': 'Tablet', 'current_stock': 8, 'minimum_stock': 2},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate a base size factor for all text
        double textScaleFactor = constraints.maxWidth / 1400;
        // Clamp the scale factor to prevent too small or too large text
        textScaleFactor = textScaleFactor.clamp(0.7, 1.2);

        // Determine if we're on a small screen (mobile)
        bool isSmallScreen = constraints.maxWidth < 800;

        return MediaQuery(
          // Override the default text scaling to use our responsive scaling
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScaleFactor)),
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  "Dashboard",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 15),

              // Responsive layout based on screen width
              if (isSmallScreen)
                _buildMobileLayout(constraints)
              else
                _buildDesktopLayout(constraints),
            ],
          ),
        );
      },
    );
  }

  // Mobile layout with cards stacked in rows of two
  Widget _buildMobileLayout(BoxConstraints constraints) {
    // Calculate dynamic aspect ratio for smaller screens
    double cardAspectRatio = constraints.maxWidth < 600 ? (1 / 0.6) : (1 / 0.5);

    return Column(
      children: [
        // First row: Sales and Purchase
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
              title: "Sales",
              value: formatNumber(10000),
              footer: "This Month Sales",
              color: Colors.green,
              constraints: constraints,
            ),
            cardView(
              title: "Purchase",
              value: formatNumber(500000),
              footer: "This Month Purchase",
              color: Colors.redAccent,
              constraints: constraints,
            ),
          ],
        ),

        const SizedBox(height: 10),

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
              title: "Today Sales",
              value: formatNumber(50000),
              footer: "Today Over all Sales",
              color: Colors.blueAccent,
              constraints: constraints,
            ),
            cardView(
              title: "Products",
              value: formatNumber(50),
              footer: "Total No of Products",
              color: Colors.orangeAccent,
              constraints: constraints,
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Low Stock Products below
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Low Stock Products",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: DataTable(
                  columnSpacing: 10.0,
                  dataRowMinHeight: constraints.maxWidth < 600 ? 40 : 48,
                  dataRowMaxHeight: constraints.maxWidth < 600 ? 50 : 60,
                  columns: [
                    DataColumn(
                      label: SizedBox(
                        width: 130,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Product Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 90,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Current Stock',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 100,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Minimum Stock',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows:
                      products.map((product) {
                        return DataRow(
                          cells: [
                            DataCell(
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(product['product_name']),
                              ),
                            ),
                            DataCell(
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product['current_stock'].toString(),
                                ),
                              ),
                            ),
                            DataCell(
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  product['minimum_stock'].toString(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Desktop layout
  Widget _buildDesktopLayout(BoxConstraints constraints) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: GridView(
              primary: false,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: (1 / 0.4),
              ),
              children: [
                cardView(
                  title: "Sales",
                  value: formatNumber(10000),
                  footer: "This Month Sales",
                  color: Colors.green,
                  constraints: constraints,
                ),
                cardView(
                  title: "Purchase",
                  value: formatNumber(500000),
                  footer: "This Month Purchase",
                  color: Colors.redAccent,
                  constraints: constraints,
                ),
                cardView(
                  title: "Today Sales",
                  value: formatNumber(50000),
                  footer: "Today Over all Sales",
                  color: Colors.blueAccent,
                  constraints: constraints,
                ),
                cardView(
                  title: "Products",
                  value: formatNumber(50),
                  footer: "Total No of Products",
                  color: Colors.orangeAccent,
                  constraints: constraints,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Low Stock Products",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: 10.0,
                      columns: [
                        DataColumn(
                          label: SizedBox(
                            width: 130,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Product Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 90,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Current Stock',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 100,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Minimum Stock',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows:
                          products.map((product) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(product['product_name']),
                                  ),
                                ),
                                DataCell(
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product['current_stock'].toString(),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product['minimum_stock'].toString(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardView({
    required String title,
    required String value,
    required String footer,
    required Color color,
    required BoxConstraints constraints,
  }) {
    // Dynamic card sizing based on screen width
    double cardPadding = constraints.maxWidth < 600 ? 8.0 : 10.0;
    double spacingHeight = constraints.maxWidth < 600 ? 3.0 : 5.0;

    // Calculate responsive font sizes
    double titleSize =
        constraints.maxWidth < 600
            ? 14.0
            : constraints.maxWidth < 800
            ? 16.0
            : 18.0;
    double valueSize =
        constraints.maxWidth < 600
            ? 18.0
            : constraints.maxWidth < 800
            ? 22.0
            : 28.0;
    double footerSize =
        constraints.maxWidth < 600
            ? 10.0
            : constraints.maxWidth < 800
            ? 12.0
            : 14.0;

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: color.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: valueSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: spacingHeight),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              footer,
              style: TextStyle(
                fontSize: footerSize,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
