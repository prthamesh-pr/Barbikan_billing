import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'about_view.dart';
import 'create_purchase_party_view.dart';
import 'party_transaction_view.dart';

class PurchasePartyListView extends StatefulWidget {
  const PurchasePartyListView({super.key});

  @override
  State<PurchasePartyListView> createState() => _PurchasePartyListViewState();
}

class _PurchasePartyListViewState extends State<PurchasePartyListView>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  final List<Map<String, dynamic>> purchasePartyList = [
    {
      'sno': 1,
      'partyName': 'ABC Traders',
      'gst': '29ABCDE1234F1Z5',
      'mobile': '9876543210',
    },
    {
      'sno': 2,
      'partyName': 'XYZ Distributors',
      'gst': '27XYZDE5678G1Z3',
      'mobile': '9876543211',
    },
    {
      'sno': 3,
      'partyName': 'LMN Suppliers',
      'gst': '30LMNDE9101H1Z7',
      'mobile': '9876543212',
    },
  ];

  int crtTab = 0;
  int? selectedPartyIndex;
  bool showDetailView = false;

  List<Widget> listPage = [PartyAboutView(), PartyTransactionView()];

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 800;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 8 : 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                isMobile
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(screenSize),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    // For mobile, show either list view or detail view based on selection
    if (showDetailView && selectedPartyIndex != null) {
      return _buildMobileDetailView();
    } else {
      return _buildPartyListView(true);
    }
  }

  Widget _buildMobileDetailView() {
    final selectedParty = purchasePartyList[selectedPartyIndex!];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with back button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      showDetailView = false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    selectedParty['partyName'],
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildActionButton(
                  icon: Iconsax.edit,
                  label: "Edit",
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Iconsax.trash,
                  label: "Delete",
                  color: Colors.red,
                ),
              ],
            ),
          ),
          TabBar(
            onTap: (value) {
              setState(() {
                crtTab = value;
              });
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: controller,
            tabs: [Tab(text: "About"), Tab(text: "Transaction")],
          ),
          Expanded(child: listPage[crtTab]),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(Size screenSize) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Party List - adjustable width based on screen size
        SizedBox(
          width: screenSize.width * 0.3,
          child: _buildPartyListView(false),
        ),
        SizedBox(width: 10),
        // Detail View
        Expanded(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                selectedPartyIndex != null
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with company name and action buttons
                        _buildDetailHeader(),
                        TabBar(
                          onTap: (value) {
                            setState(() {
                              crtTab = value;
                            });
                          },
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          controller: controller,
                          tabs: [Tab(text: "About"), Tab(text: "Transaction")],
                        ),
                        Expanded(child: listPage[crtTab]),
                      ],
                    )
                    : Center(
                      child: Text(
                        "Select a party to view details",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
          ),
        ),
      ],
    );
  }

  Widget _buildPartyListView(bool isMobile) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(isMobile ? 8.0 : 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purchase Party",
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Manage and view registered purchase parties",
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _buildAddButton(isMobile),
              ],
            ),
          ),
          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 8.0 : 10.0,
              vertical: 4.0,
            ),
            child: SizedBox(
              height: 40,
              child: TextFormField(
                cursorHeight: 20,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, size: 18),
                  filled: true,
                  fillColor: Color(0xffEEEEEE),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: "Search ...",
                ),
              ),
            ),
          ),
          // Party list vertical layout - Improved formatting
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      // List header
                      Container(
                        color: Theme.of(
                          context,
                        ).primaryColor.withAlpha((0.1 * 255).toInt()),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        width: double.infinity,
                        child: Text(
                          'Purchase Parties',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // List body
                      Expanded(
                        child: ListView.builder(
                          itemCount: purchasePartyList.length,
                          itemBuilder: (context, index) {
                            final party = purchasePartyList[index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedPartyIndex = index;
                                  if (isMobile) {
                                    showDetailView = true;
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                color:
                                    selectedPartyIndex == index
                                        ? Theme.of(context).primaryColor
                                            .withAlpha((0.1 * 255).toInt())
                                        : (index % 2 == 0
                                            ? Colors.white
                                            : Colors.grey.shade50),
                                child: ListTile(
                                  leading: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: Text(
                                      party['sno'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    party['partyName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    color: Colors.grey,
                                    icon: Icon(Iconsax.more),
                                    onPressed: () {
                                      _showOptionsMenu(context, index);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailHeader() {
    if (selectedPartyIndex == null) return SizedBox();

    final selectedParty = purchasePartyList[selectedPartyIndex!];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedParty['partyName'],
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Row(
            children: [
              _buildActionButton(
                icon: Iconsax.edit,
                label: "Edit",
                color: Colors.blue,
              ),
              const SizedBox(width: 10),
              _buildActionButton(
                icon: Iconsax.trash,
                label: "Delete",
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(bool isMobile) {
    return GestureDetector(
      onTap: () {
        // Option 1: Navigate to a new full screen page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Scaffold(body: CreatePurchasePartyView()),
          ),
        );

        // Option 2: If you're using a drawer approach
        // Make sure scaffoldKey is defined in your class
        // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        //
        // Then update your state or provider
        // setState(() {
        //   currentView = CreatePurchasePartyView();
        // });
        // scaffoldKey.currentState!.openEndDrawer();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 15,
          vertical: isMobile ? 6 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: isMobile ? 16 : 20),
            if (!isMobile) ...[
              const SizedBox(width: 5),
              Text(
                "Add New",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 15,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: isMobile ? 16 : 18),
          if (!isMobile) ...[
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, int index) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Text('Edit'),
          onTap: () {
            // Handle edit
          },
        ),
        PopupMenuItem(
          child: Text('Delete'),
          onTap: () {
            // Handle delete
          },
        ),
        PopupMenuItem(
          child: Text('View Details'),
          onTap: () {
            setState(() {
              selectedPartyIndex = index;
              if (MediaQuery.of(context).size.width < 800) {
                showDetailView = true;
              }
            });
          },
        ),
      ],
    );
  }
}
