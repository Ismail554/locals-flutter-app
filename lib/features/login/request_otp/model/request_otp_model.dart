class RequestOtpModel {
  final String email;

  const RequestOtpModel({this.email = ''});

  RequestOtpModel copyWith({String? email}) {
    return RequestOtpModel(email: email ?? this.email);
  }
}
