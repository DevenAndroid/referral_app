//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class BottomNavbar extends StatefulWidget {
//   const BottomNavbar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavbar> createState() => _BottomNavbarState();
// }
//
// class _BottomNavbarState extends State<BottomNavbar> {
//   int currentDrawer = 0;
//   Rx<int> currentIndex = 0.obs;
//   // final itemss = <Widget>[
//   //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
//   //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
//   //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
//   //   Image.asset('assets/images/home.png',height: 20,color: Colors.black,),
//   //
//   // ];
//
//   // List<TabItem> items = const [
//   //
//   //   TabItem(
//   //     icon : Icons.home_filled,
//   //     title: 'Home',
//   //   ),
//   //   TabItem(
//   //     icon: Icons.featured_video,
//   //     title: 'Featured',
//   //   ),
//   //   TabItem(
//   //     icon: Icons.list_alt,
//   //     title: 'Orders',
//   //   ),
//   //   TabItem(
//   //     icon: Icons.settings,
//   //     title: 'Settings',
//   //   ),
//   // ];
//
//   List screens = [
//     const HomePageScreen(),
//     const AddNewCardScreen(),
//     const MyOrderScreen(),
//     const MyProfileScreen(),
//   ];
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         drawer:Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               SizedBox(
//                 height: 230,
//                 child: DrawerHeader(
//                     decoration: const BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF7ED957),
//                             Color(0xFF68C541),
//                           ],
//                         )
//                     ),
//                     child: Align(
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/images/Ellipse 67.png',
//                             height: 100,
//                           ),
//                           Text('Williams Jones',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 18,
//                                 color: const Color(0xFFFFFFFF),
//                                 fontWeight: FontWeight.w600,)),
//                           Text('williamsjones@gmail.com',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 15,
//                                 color: const Color(0xFFFFFFFF),
//                                 fontWeight: FontWeight.w400,)),
//                         ],
//                       ),
//                     )),
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/note-2.png',
//                   height: 20,
//                 ),
//                 title:  Text('My Orders',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 0;
//                     Get.toNamed(MyRouters.myOrderScreen);
//                   });
//                 },
//               ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/personImg.png',
//                   height: 20,
//                 ),
//                 title:  Text('My profile',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 1;
//                     Get.toNamed(MyRouters.myProfileScreen);
//                     // Get.to(VendorOrderList());
//                   });
//                 },
//               ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/notification-img.png',
//                   height: 20,
//                 ),
//                 title:  Text('Notification',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 2;
//                     Get.toNamed(MyRouters.notificationScreen);
//                   });
//                 },
//               ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/location-my.png',
//                   height: 20,
//                 ),
//                 title:  Text('My Address',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 3;
//                     Get.toNamed(MyRouters.myAddressScreen);
//                   });
//                 },
//               ),
//               // const Divider(
//               //   height: 5,
//               //   color: Color(0xffEFEFEF),
//               //   thickness: 1,
//               // ),
//               // ListTile(
//               //   visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//               //   leading: Image.asset(
//               //     'assets/images/notebook_reference.png',
//               //     height: 20,
//               //   ),
//               //   title:  Text('Refer and Earn',
//               //       style: GoogleFonts.poppins(
//               //         fontSize: 15,
//               //         color: const Color(0xFF4F535E),
//               //         fontWeight: FontWeight.w400,)),
//               //   onTap: () {
//               //     setState(() {
//               //       currentDrawer = 4;
//               //       // Get.to(VendorNotificationScreen());
//               //     });
//               //   },
//               // ),
//               // const Divider(
//               //   height: 5,
//               //   color: Color(0xffEFEFEF),
//               //   thickness: 1,
//               // ),
//               // ListTile(
//               //   visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//               //   leading: Image.asset(
//               //     'assets/images/bx_wallet.png',
//               //     height: 20,
//               //   ),
//               //   title:  Text('My Wallet',
//               //       style: GoogleFonts.poppins(
//               //         fontSize: 15,
//               //         color: const Color(0xFF4F535E),
//               //         fontWeight: FontWeight.w400,)),
//               //   onTap: () {
//               //     setState(() {
//               //       currentDrawer = 5;
//               //       Get.toNamed(MyRouters.myCartScreen);
//               //     });
//               //   },
//               // ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/metro-security.png',
//                   height: 20,
//                 ),
//                 title:  Text('Privacy Policy',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 6;
//                     // Get.to(VendorHelpCenterScreen());
//                   });
//                 },
//               ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/chatchatting.png',
//                   height: 20,
//                 ),
//                 title:  Text('Message',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 7;
//                     // Get.to(SettingScreenVendor());
//                   });
//                 },
//               ),
//               const Divider(
//                 height: 5,
//                 color: Color(0xffEFEFEF),
//                 thickness: 1,
//               ),
//               ListTile(
//                 visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
//                 leading: Image.asset(
//                   'assets/images/logout.png',
//                   height: 16,
//                 ),
//                 title:  Text('Logout',
//                     style: GoogleFonts.poppins(
//                       fontSize: 15,
//                       color: const Color(0xFF4F535E),
//                       fontWeight: FontWeight.w400,)),
//                 onTap: () {
//                   setState(() {
//                     currentDrawer = 7;
//                     // Get.to(SettingScreenVendor());
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: screens[currentIndex.value],
//         extendBody: true,
//         backgroundColor: Colors.white,
//         bottomNavigationBar:  ConvexAppBar(
//           backgroundColor: Colors.white,
//             color: const Color(0xFF4E5B5F),
//             height: 45,
//             activeColor: Colors.green,
//             onTap: (int index) => currentIndex.value = index,
//             items: [
//             TabItem(
//                 icon : Image.asset('assets/images/home1.png',color: const Color(0xFF4E5B5F),),
//                 title: 'Home',
//               activeIcon: Image.asset('assets/images/home1.png')
//               ),
//               TabItem(
//                 icon: Icons.featured_video,
//                 title: 'Featured',
//               ),
//               TabItem(
//                 icon: Icons.list_alt,
//                 title: 'Orders',
//               ),
//               TabItem(
//                 icon: Icons.settings,
//                 title: 'Settings',
//               ),
//             ]
//
//         //   BottomBarInspiredInside(
//         //   height: 40.0,
//         //   items: items,
//         //   backgroundColor:   Colors.white,
//         //   color: const Color(0xFF4E5B5F),
//         //   titleStyle: GoogleFonts.plusJakartaSans(
//         //       fontSize: 10,
//         //       fontWeight: FontWeight.w400,
//         //       color: const Color(0xFF4E5B5F)),
//         //   colorSelected: Colors.white,
//         //   indexSelected: currentIndex.value,
//         //   onTap: (int index) => currentIndex.value = index,
//         //   chipStyle: const ChipStyle(convexBridge: true),
//         //   itemStyle: ItemStyle.circle,
//         //   animated: true,
//         //
//         // );
//       ));
//     });
//   }
// }