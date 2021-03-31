// class RenterModel {
//   final String bookId;
//   final String time;
//   final String userName;
//
//   RenterModel({this.bookId, this.time, this.userName});
//
//   /// make Object to Map
//   Map<String, Object> toJson() {
//     return {'bookId': bookId ?? '', 'time': time ?? '', 'userName': userName};
//   }
//
//   /// make Map to Object
//   static RenterModel fromJson(Map<String, dynamic> json) {
//     return RenterModel(
//         bookId: json['bookId'], time: json['time'], userName: json['userName']);
//   }
// }
