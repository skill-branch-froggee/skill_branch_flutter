import './models/user.dart';
//import 'string_util.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    print(user.toString());

    if (!users.containsKey(user.login)) {
      // users.addAll({user.login: user}); вариант добавления
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exist");
    }
  }

  User getUserByLogin(String login) {
    print('login: $login');
    if (!users.containsKey(login)) {
      throw Exception("User's login $login is not registred");
    } else {
      return users[login];
    }
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User(name: fullName, email: email);
    print('Register User By Email ${user.toString()}');
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('A user with this email already exists');
    }
    return user;
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User(name: fullName, phone: phone);
    print('Register User By Phone ${user.toString()}');
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception('A user with this phone already exists');
    }
    return user;
  }

  User findUserInFriends(String login, User user) {
    if (!users.containsKey(login)) {
      throw Exception("${user.login} is not a friend of the login");
    } else {
      return users[login].friends.firstWhere(
          (element) => element.login == user.login,
          orElse: () =>
              throw Exception("${user.login} is not a friend of the login"));
    }
  }

  void setFriends(String login, Iterable<User> newFriend) {
    if (!users.containsKey(login)) {
      throw Exception("$login is not registered user");
    } else {
      users[login].addFriend(newFriend);
      print(users.toString());
    }
  }

  List<User> importUsers(List<String> items) {
    users.clear();
    List<User> result = [];
    items.forEach((element) {
      String name = element.split(";")[0].trim();
      String email = element.split(";")[1].trim();
      String phone = element.split(";")[2].trim();
      registerUser(name, phone, email);
      result.add(getUserByLogin(email));
    });
    return result;
  }
}
