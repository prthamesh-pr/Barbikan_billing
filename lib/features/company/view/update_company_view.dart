import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UpdateCompanyView extends StatefulWidget {
  const UpdateCompanyView({super.key});

  @override
  State<UpdateCompanyView> createState() => _UpdateCompanyViewState();
}

class _UpdateCompanyViewState extends State<UpdateCompanyView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Company",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Mange and collaborate within your organization's teams",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEEEEEE),
                  ),
                  child: Center(child: Icon(Icons.close, size: 20)),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 0, color: Color(0xffEEEEEE)),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Text(
                "Gendral Information",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company Name",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.building, size: 18),
                              filled: true,
                              fillColor: Color(0xffEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              hintText: "Company Name",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mobile Number",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.call, size: 18),
                              filled: true,
                              fillColor: Color(0xffEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              hintText: "Contact Number",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "GST Number",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.flag, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "GST Number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "FSSAI Number",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.reserve, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "FSSAI Number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bill Prefix",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.clipboard, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "Bill Prefix",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: 10),
              Text(
                "Billing Address",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            cursorHeight: 20,
                            maxLines: 5,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffEEEEEE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              hintText: "Address",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.location, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "City",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "State",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.global, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "State",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: 10),
              Text(
                "Bank Details",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bank Name",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.shop, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "Bank Name",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account Number",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Iconsax.card, size: 18),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "Account Number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "IFSC Code",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.money_recive,
                                  size: 18,
                                ),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "IFSC Code",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "UPI Number",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorHeight: 20,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Iconsax.receipt_item,
                                  size: 18,
                                ),
                                filled: true,
                                fillColor: Color(0xffEEEEEE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                hintText: "UPI Number",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xffEEEEEE),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Update Now",
                      style: Theme.of(
                        context,
                      ).textTheme.labelLarge!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
