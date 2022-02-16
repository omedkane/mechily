import 'package:mechily/Models/OneUser.dart';

class Review {
  // ignore: unused_field
  final String _id;
  final User reviewer;
  final String review;
  final int rating;

  Review(this._id, this.reviewer, this.review, this.rating);
}
