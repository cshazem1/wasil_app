class Reviews {
  Reviews({
      this.rating, 
      this.comment, 
      this.date, 
      this.reviewerName, 
      this.reviewerEmail,});

  Reviews.fromJson(dynamic json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;


}