import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_sales.dart';

class SalesList extends StatefulWidget {
  const SalesList({super.key});

  @override
  State<SalesList> createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  String _selectedFilter = "All";
  String _sortBy = "Date";
  bool _sortAscending = false;

  // Sample data - replace with your actual data source
  final List<SalesData> _salesData = List.generate(
    25,
    (index) => SalesData(
      id: "INV-${2000 + index}",
      customerName: "Customer ${index + 1}",
      date: DateTime.now().subtract(Duration(days: index * 2)),
      amount: 100.0 + (index * 50.0),
      status:
          index % 4 == 0
              ? "Pending"
              : index % 3 == 0
              ? "Paid"
              : "Completed",
      items: (index % 3 + 2).toString(),
    ),
  );

  List<SalesData> get filteredSales {
    List<SalesData> result = List.from(_salesData);

    // Apply filter
    if (_selectedFilter != "All") {
      result = result.where((sale) => sale.status == _selectedFilter).toList();
    }

    // Apply search
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      result =
          result
              .where(
                (sale) =>
                    sale.id.toLowerCase().contains(query) ||
                    sale.customerName.toLowerCase().contains(query),
              )
              .toList();
    }

    // Apply sorting
    result.sort((a, b) {
      int comparison;
      switch (_sortBy) {
        case "ID":
          comparison = a.id.compareTo(b.id);
          break;
        case "Customer":
          comparison = a.customerName.compareTo(b.customerName);
          break;
        case "Amount":
          comparison = a.amount.compareTo(b.amount);
          break;
        case "Date":
        default:
          comparison = a.date.compareTo(b.date);
      }
      return _sortAscending ? comparison : -comparison;
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isMobile),
            const SizedBox(height: 24),
            _buildFilterBar(isMobile),
            const SizedBox(height: 16),
            Expanded(child: _buildSalesList(isMobile)),
            const SizedBox(height: 16),
            _buildSummary(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddSales()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Sale"),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sales",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              "Manage your sales records",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        if (!isMobile)
          Row(
            children: [
              _buildStatCard(
                title: "Today",
                value: "\$1,245.00",
                icon: Icons.trending_up,
                color: Colors.green,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                title: "This Month",
                value: "\$24,567.00",
                icon: Icons.trending_up,
                color: Colors.indigo,
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isMobile) {
    return isMobile
        ? Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildFilterDropdown()),
                const SizedBox(width: 8),
                Expanded(child: _buildSortDropdown()),
              ],
            ),
          ],
        )
        : Row(
          children: [
            Expanded(flex: 2, child: _buildSearchField()),
            const SizedBox(width: 16),
            Expanded(child: _buildFilterDropdown()),
            const SizedBox(width: 16),
            Expanded(child: _buildSortDropdown()),
          ],
        );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search sales...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          isExpanded: true,
          hint: const Text("Filter by Status"),
          items:
              ["All", "Pending", "Paid", "Completed"]
                  .map(
                    (status) =>
                        DropdownMenuItem(value: status, child: Text(status)),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedFilter = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          isExpanded: true,
          hint: const Text("Sort by"),
          items:
              ["Date", "ID", "Customer", "Amount"]
                  .map(
                    (field) => DropdownMenuItem(
                      value: field,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(field),
                          if (_sortBy == field)
                            Icon(
                              _sortAscending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              size: 16,
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                if (_sortBy == value) {
                  _sortAscending = !_sortAscending;
                } else {
                  _sortBy = value;
                  _sortAscending = false;
                }
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSalesList(bool isMobile) {
    if (isMobile) {
      return _buildMobileSalesList();
    } else {
      return _buildDesktopSalesList();
    }
  }

  Widget _buildMobileSalesList() {
    final sales = filteredSales;

    return sales.isEmpty
        ? _buildEmptyState()
        : ListView.builder(
          controller: scrollController,
          itemCount: sales.length,
          itemBuilder: (context, index) {
            final sale = sales[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          sale.id,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        _buildStatusBadge(sale.status),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(sale.customerName),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text(DateFormat('MMM dd, yyyy').format(sale.date)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.shopping_bag_outlined,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 8),
                            Text("${sale.items} items"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${sale.amount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility_outlined),
                              onPressed: () {},
                              tooltip: "View details",
                              iconSize: 20,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit_outlined),
                              onPressed: () {},
                              tooltip: "Edit",
                              iconSize: 20,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {},
                              tooltip: "Delete",
                              iconSize: 20,
                              color: Colors.red[400],
                            ),
                          ],
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

  Widget _buildDesktopSalesList() {
    final sales = filteredSales;

    return sales.isEmpty
        ? _buildEmptyState()
        : Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Scrollbar(
            controller: scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: const Text("ID"),
                    onSort: (_, __) {
                      setState(() {
                        _sortBy = "ID";
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Customer"),
                    onSort: (_, __) {
                      setState(() {
                        _sortBy = "Customer";
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  DataColumn(
                    label: const Text("Date"),
                    onSort: (_, __) {
                      setState(() {
                        _sortBy = "Date";
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  const DataColumn(label: Text("Items")),
                  DataColumn(
                    label: const Text("Amount"),
                    onSort: (_, __) {
                      setState(() {
                        _sortBy = "Amount";
                        _sortAscending = !_sortAscending;
                      });
                    },
                  ),
                  const DataColumn(label: Text("Status")),
                  const DataColumn(label: Text("Actions")),
                ],
                rows:
                    sales.map((sale) {
                      return DataRow(
                        cells: [
                          DataCell(Text(sale.id)),
                          DataCell(Text(sale.customerName)),
                          DataCell(
                            Text(DateFormat('MMM dd, yyyy').format(sale.date)),
                          ),
                          DataCell(Text("${sale.items} items")),
                          DataCell(Text("\$${sale.amount.toStringAsFixed(2)}")),
                          DataCell(_buildStatusBadge(sale.status)),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.visibility_outlined),
                                  onPressed: () {},
                                  tooltip: "View details",
                                  iconSize: 20,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined),
                                  onPressed: () {},
                                  tooltip: "Edit",
                                  iconSize: 20,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () {},
                                  tooltip: "Delete",
                                  iconSize: 20,
                                  color: Colors.red[400],
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

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    switch (status) {
      case "Paid":
        badgeColor = Colors.green;
        break;
      case "Pending":
        badgeColor = Colors.orange;
        break;
      case "Completed":
        badgeColor = Colors.blue;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: badgeColor,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 72, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No sales found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting your filters or add a new sale",
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          // Update the button in the empty state
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSales()),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Sale"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    final sales = filteredSales;
    final totalAmount = sales.fold(0.0, (sum, sale) => sum + sale.amount);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.05 * 255).toInt()),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${sales.length} sales",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Text(
            "Total: \$${totalAmount.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String id;
  final String customerName;
  final DateTime date;
  final double amount;
  final String status;
  final String items;

  SalesData({
    required this.id,
    required this.customerName,
    required this.date,
    required this.amount,
    required this.status,
    required this.items,
  });
}
