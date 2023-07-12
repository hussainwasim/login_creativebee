// import 'dart:convert';

// import 'package:fin/res/style/colors.dart';
// import 'package:fin/view/admin_dashbord/admin_dashboard.dart';
// import 'package:fin/view/driver_dashbord/driver_dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import '../../models/customer_model.dart';
// import 'customer_detail.dart';

// class CustomerList extends StatefulWidget {
//   const CustomerList({super.key});

//   @override
//   State<CustomerList> createState() => _CustomerListState();
// }

// class _CustomerListState extends State<CustomerList> {
//   bool isUserLoading = false;
//   static const storage = FlutterSecureStorage();
//   // var role = storage.read(key: 'User_Role');
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     usersFuture = getUsers();
//     setState(() {
//       isUserLoading = true;
//     });
//   }

//   Future<CustomerModel> usersFuture = getUsers();

//   static Future<CustomerModel> getUsers() async {
//     var loginResponse = await storage.read(key: 'LOGIN_RESS');
//     var url = "http://product.artsify.in/public/api/customers/";
//     Map<String, String> requestHeaders = {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer $loginResponse'
//     };

//     final response = await http.get(Uri.parse(url), headers: requestHeaders);
//     final body = json.decode(response.body);
//     // print(body['data']);
//     return CustomerModel.fromJson(jsonDecode(response.body));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('CUSTOMER LIST ',
//               style: GoogleFonts.inter(
//                 textStyle: const TextStyle(
//                   color: textPrimary,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                 ),
//               )),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: textPrimary,
//             ),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const DriverDashboard()),
//                 (route) => false,
//               );
//               // Navigator.pushAndRemoveUntil(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) =>  == 1
//               //         ? const DriverDashboard()
//               //         : const AdminDashboard(),
//               //   ),
//               //   (route) => false,
//               // );
//             },
//           ),
//           elevation: 0,
//         ),
//         body: !isUserLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : FutureBuilder<CustomerModel>(
//                 future: usersFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasData) {
//                       final users = snapshot.data!;
//                       return users.data != null && users.data!.isNotEmpty
//                           ? buildUsers(users)
//                           : Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/nodata.png',
//                                     height: 180,
//                                     width: 180,
//                                   ),
//                                   const SizedBox(
//                                     height: 50,
//                                   ),
//                                   const Text(
//                                     'Cutomer Not  Found!',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff002145)),
//                                   ),
//                                   const SizedBox(
//                                     height: 30,
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       // MaterialPageRoute(
//                                       //   builder: (context) =>

//                                       // );
//                                     },
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.8,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                         color: Color(0xff002145),
//                                         borderRadius: BorderRadius.circular(40),
//                                       ),
//                                       child: const Center(
//                                         child: Text(
//                                           'Add Customer',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w400,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.15,
//                                   ),
//                                 ],
//                               ),
//                             );
//                     } else {
//                       return Center(child: Text('no data'));
//                     }
//                   }
//                   return Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height,
//                     color: Colors.white,
//                     child: const Center(child: CircularProgressIndicator()),
//                   );
//                 },
//               ));
//   }

//   Widget buildUsers(CustomerModel users) => ListView.builder(
//       itemCount: users.data?.length,
//       itemBuilder: (context, index) {
//         // print(users.data);
//         var User = users.data![index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => CustomerDetails(
//                           id: User.cId,
//                         )));
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xFFEAEBF4),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
//                       ),
//                     ),
//                     title: Row(
//                       children: [
//                         Text(
//                           '${users.data![index].name}',
//                           style: GoogleFonts.inter(
//                               textStyle: const TextStyle(
//                             color: Color(0xFF424242),
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           )),
//                         ),
//                         Text(
//                           ' - ${users.data![index].customerId}',
//                           style: GoogleFonts.inter(
//                               textStyle: const TextStyle(
//                             color: Color(0xFF424242),
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                           )),
//                         ),
//                       ],
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 3),
//                       child: Row(
//                         children: [
//                           Text(
//                             "Finance : ",
//                             style: GoogleFonts.inter(
//                                 textStyle: const TextStyle(
//                               color: Color(0xFF424242),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             )),
//                           ),
//                           Text(
//                             " ${users.data![index].loanAmount} :",
//                             style: GoogleFonts.inter(
//                                 textStyle: const TextStyle(
//                               color: Color(0xFF019910),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w800,
//                             )),
//                           ),
//                           Text(
//                             " ${users.data![index].balanceAmount}",
//                             style: TextStyle(
//                               color: Color(0xFFFF7E7E),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     trailing: Image.asset(
//                       'assets/images/arrow.png',
//                       height: 20,
//                     )),
//               ),
//             ),
//           ),
//         );
//       });
// }
