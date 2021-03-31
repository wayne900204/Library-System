// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'bloc/borrow_bloc.dart';
//
// //my own imports
// class QRCodeBarPage extends StatefulWidget {
//   @override
//   _QRCodeBarPageState createState() => _QRCodeBarPageState();
// }
//
// class _QRCodeBarPageState extends State<QRCodeBarPage> {
//   Size size;
//   String barcode = "";
//   BorrowBloc _qrCodeBloc;
//   final TextEditingController _userNameController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     _qrCodeBloc = BlocProvider.of<BorrowBloc>(context);
//   }
//
//   _scanBarCode(String userName) async {
//     await FlutterBarcodeScanner.scanBarcode(
//             "#ff6666", "Cancel", true, ScanMode.BARCODE)
//         .then((value) {
//       _qrCodeBloc.add(BorrowOnClick(bookNumber: value,userName: userName));
//       // BlocProvider.of<QrCodeBloc>(context)
//       //     .add(QrCodeOnClick(bookId: value.toString()));
//       print("Book ID is: " + value);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rent / Return',style: TextStyle(color: Colors.white),),
//         centerTitle: true,
//         iconTheme: IconThemeData(
//           color: Colors.white,
//         ),
//       ),
//       body: BlocConsumer<BorrowBloc, BorrowState>(
//         listener: (context, state) {
//           if (state is BorrowInitial) {
//             Scaffold.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                   content: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text('Logging In...'),
//                   CircularProgressIndicator(),
//                 ],
//               )));
//           }
//           if (state is BorrowIsSuccessful) {
//             Scaffold.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                 content: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[Text(state.activityType), Icon(Icons.check)],
//                 ),
//                 backgroundColor: Colors.cyan,
//               ));
//           }
//           if (state is BorrowIsFailure) {
//             Scaffold.of(context)
//               ..hideCurrentSnackBar()
//               ..showSnackBar(SnackBar(
//                 content: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[Text('Login Failure'), Icon(Icons.error)],
//                 ),
//                 backgroundColor: Colors.red,
//               ));
//           }
//           return Container();
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: Colors.black.withOpacity(.35),
//             body: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   buildName(),
//                   IconButton(icon: Icon(Icons.check,size: 50,color: Colors.red,), onPressed: () async{
//                     return _scanBarCode(_userNameController.text);
//                   })
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   /// build UserName Field
//   Padding buildName(){
//     return Padding(
//       padding: const EdgeInsets.only(left: 32.0, right: 32.0),
//       child: Container(
//         child: TextField(
//           controller: _userNameController,
//           decoration: InputDecoration(
//               hintText: 'userName',
//               filled: true,
//               fillColor: Colors.cyan[300],
//               focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                       bottomLeft: Radius.circular(7),
//                       topRight: Radius.circular(7)),
//                   borderSide: BorderSide(
//                       color: Colors.blue, width: 2.0)),
//               disabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                       bottomLeft: Radius.circular(7),
//                       topRight: Radius.circular(7)),
//                   borderSide: BorderSide(
//                       color: Colors.blue, width: 2.0)),
//               enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                       bottomLeft: Radius.circular(7),
//                       topRight: Radius.circular(7)),
//                   borderSide: BorderSide(
//                       color: Colors.black, width: 1.0)),
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       bottomRight: Radius.circular(30),
//                       bottomLeft: Radius.circular(7),
//                       topRight: Radius.circular(7)),
//                   borderSide: BorderSide(
//                       color: Colors.black, width: 1.0))),
//         ),
//       ),
//     );
//   }
// }
