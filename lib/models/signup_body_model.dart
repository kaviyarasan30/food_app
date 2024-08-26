class SignUpBody {
  String name;
  String phone;
  String email;
  String password;
  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
// convert the user given data(object) to json data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["f_name"] = name;
    data["phone"] = phone;
    data["email"] = email;
    data["password"] = password;
    return data;
  }
}
