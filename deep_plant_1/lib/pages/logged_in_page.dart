import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInPage extends StatefulWidget {
  const LoggedInPage({super.key});

  @override
  State<LoggedInPage> createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Login Succeed!'),
        actions: [
          IconButton(
            onPressed: () {
              _authentication.signOut();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 70, // 버튼의 가로 크기를 조정할 수 있습니다.
                  height: 70, // 버튼의 세로 크기를 조정할 수 있습니다.
                  color: Colors.blue, // 버튼의 배경색을 설정할 수 있습니다.
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 70, // 버튼의 가로 크기를 조정할 수 있습니다.
                  height: 70, // 버튼의 세로 크기를 조정할 수 있습니다.
                  color: Colors.red, // 버튼의 배경색을 설정할 수 있습니다.
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 70, // 버튼의 가로 크기를 조정할 수 있습니다.
                  height: 70, // 버튼의 세로 크기를 조정할 수 있습니다.
                  color: Colors.yellow, // 버튼의 배경색을 설정할 수 있습니다.
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 70, // 버튼의 가로 크기를 조정할 수 있습니다.
                  height: 70, // 버튼의 세로 크기를 조정할 수 있습니다.
                  color: Colors.black, // 버튼의 배경색을 설정할 수 있습니다.
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 70, // 버튼의 가로 크기를 조정할 수 있습니다.
                  height: 70, // 버튼의 세로 크기를 조정할 수 있습니다.
                  color: Colors.green, // 버튼의 배경색을 설정할 수 있습니다.
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
