class UserModel {
  final String idUser;
  final String fullnameUser;
  final String addressUser;
  final String phoneUser;
  final String emailUser;
  final String passwordUser;
  final String roleUser;

  UserModel({
    this.idUser,
    this.fullnameUser,
    this.addressUser,
    this.phoneUser,
    this.emailUser,
    this.passwordUser,
    this.roleUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        idUser: data['id_user'],
        fullnameUser: data['fullname'],
        addressUser: data['address'],
        phoneUser: data['phone'],
        emailUser: data['email'],
        passwordUser: data['password'],
        roleUser: data['role']);
  }
}
