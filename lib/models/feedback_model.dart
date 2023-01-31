class FeedbackModel {
  String name;
  String email;
  String mobileNo;
  String feedback;

  FeedbackModel(this.name, this.email, this.mobileNo, this.feedback);

  factory FeedbackModel.fromJson(dynamic json) {
    return FeedbackModel("${json['name']}", "${json['email']}",
        "${json['mobileNo']}", "${json['feedback']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
    'name': name,
    'email': email,
    'mobileNo': mobileNo,
    'feedback': feedback
  };
}