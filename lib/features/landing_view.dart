import 'package:flutter/material.dart';
import 'category/category_list_view.dart';
import 'company/view/company_list_view.dart';
import 'create_form/create_view.dart';
import 'dashboard/dashboard_view.dart';
import 'invoice/invoice_list_view.dart';
import 'party/customer/customer_list_view.dart';
import 'party/purchase_party/purchase_party_list_view.dart';
import 'product/product_list_view.dart';
import 'purchase/purchase_list_view.dart';
import 'sidebar/menu_view.dart';
import 'sidebar/sidebar_view.dart';
import 'user_access/view/user_access_view.dart';
import 'stock/stock_list.dart';
import 'sales/sales_list.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  String currentCompany = "cafeteria";
  bool _isSidebarVisible = true; // Track sidebar visibility
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  List<Widget> pageList = const [
    DashboardView(),
    UserAndAccessView(),
    CompanyListView(),
    PurchasePartyListView(),
    CustomerListView(),
    CategoryListView(),
    ProductListView(),
    PurchaseListView(),
    InvoiceListView(),
    StockListView(),
    SalesList(),
  ];

  refreshPage() {
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleSidebar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    
    if (isSmallScreen) {
      // For small screens, open drawer which overlays content
      scaffoldKey.currentState?.openDrawer();
    } else {
      // For larger screens, toggle sidebar visibility
      setState(() {
        _isSidebarVisible = !_isSidebarVisible;
      });
    }
  }

  @override
  void initState() {
    sideBarconfig.addListener(refreshPage);
    super.initState();
  }

  @override
  void dispose() {
    sideBarconfig.removeListener(refreshPage); // Fixed: was adding instead of removing
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    
    // Automatically hide sidebar on small screens
    if (isSmallScreen && _isSidebarVisible && screenWidth < 500) {
      _isSidebarVisible = false;
    }
    
    // Sidebar width based on screen size - changed from 0.7 to 0.75 (75%)
    final sidebarWidth = isSmallScreen ? screenWidth * 0.75 : 250.0;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: CreationView(),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: _toggleSidebar, // Toggle sidebar on menu press
          icon: Icon(_isSidebarVisible ? Icons.menu_open : Icons.menu),
          splashRadius: 20,
          iconSize: 20,
        ),
        centerTitle: false,
        titleSpacing: 0,
        title: Image.asset("assets/image/barbikan_logo.png", height: 35),
        // title: SizedBox(
        //   height: 40,
        //   width: 250,
        //   child: TextFormField(
        //     decoration: InputDecoration(
        //       prefixIcon: Icon(Icons.search, size: 18),
        //       filled: true,
        //       fillColor: Color(0xffEEEEEE),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: BorderSide.none,
        //       ),
        //       contentPadding: EdgeInsets.symmetric(horizontal: 15),
        //       hintText: "Search ...",
        //     ),
        //   ),
        // ),
        actions: [
          SizedBox(
            width: isSmallScreen ? 150 : 250, // Adjust width for small screens
            height: 40,
            child: DropdownButtonFormField(
              value: currentCompany,
              isExpanded: true,
              items: [
                DropdownMenuItem(value: "cafeteria", child: Text("Cafeteria")),
                DropdownMenuItem(value: "play", child: Text("Play Area")),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffEEEEEE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintText: "Choose Company",
              ),
              onChanged: (onChanged) {},
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: isSmallScreen ? 
        Drawer(
          width: screenWidth * 0.75, // Set drawer width to 75% of screen
          child: SideBarView(),
        ) : null,
      body: Row(
        children: [
          // Conditionally show sidebar based on visibility state
          if (_isSidebarVisible)
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: double.infinity,
              width: sidebarWidth,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Expanded(child: SideBarView())],
              ),
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffEEEEEE),
                      borderRadius: BorderRadius.only(
                        topLeft: _isSidebarVisible ? Radius.circular(10) : Radius.zero,
                      ),
                    ),
                    child: pageList[sideBarconfig.currentIndex],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}