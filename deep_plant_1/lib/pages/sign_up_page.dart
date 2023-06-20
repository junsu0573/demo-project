import 'package:deep_plant_1/pages/logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>(); // form 구성

  String userId = '';
  String userPw = '';
  String userCPw = '';

  bool isLoading = false;

  // firbase authentic
  final _authentication = FirebaseAuth.instance;

  // 유효성 확인
  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _fetchData() async {
    // 데이터를 가져오는 비동기 함수
    setState(() {
      isLoading = true; // 로딩 상태를 활성화
    });

    // 데이터를 가져오는 비동기 작업
    try {
      if (userPw.length < 6 || userPw != userCPw) {
        throw Error();
      }
      await _authentication.createUserWithEmailAndPassword(
          email: userId, password: userPw);
    } catch (e) {
      setState(() {
        isLoading = false; // 로딩 상태를 비활성화
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('아이디와 비밀번호를 확인하세요'),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    setState(() {
      isLoading = false; // 로딩 상태를 비활성화
    });

    final currentContext = context;

    Future.delayed(Duration.zero, () {
      Navigator.push(
        currentContext,
        MaterialPageRoute(builder: (context) => const LoggedInPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.black, BlendMode.modulate),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 300, // 이미지의 가로 크기 조절
                        height: 60, // 이미지의 세로 크기 조절
                      ),
                    ),
                  ),
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(60, 5, 60, 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return '올바른 아이디를 입력하세요.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userId = value!;
                      },
                      onChanged: (value) {
                        userId = value;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: 'ID', // 입력 필드 위에 표시될 라벨 텍스트
                          hintText: '아이디를 입력하세요', // 입력 필드에 힌트로 표시될 텍스트
                          prefixIcon:
                              const Icon(Icons.person), // 입력 필드 왼쪽에 표시될 아이콘
                          suffixIcon:
                              const Icon(Icons.clear), // 입력 필드 오른쪽에 표시될 아이콘
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return '올바른 비밀번호를 입력하세요.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userPw = value!;
                      },
                      onChanged: (value) {
                        userPw = value;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: 'PW', // 입력 필드 위에 표시될 라벨 텍스트
                          hintText: '비빌번호를 입력하세요', // 입력 필드에 힌트로 표시될 텍스트
                          prefixIcon:
                              const Icon(Icons.key), // 입력 필드 왼쪽에 표시될 아이콘
                          suffixIcon:
                              const Icon(Icons.clear), // 입력 필드 오른쪽에 표시될 아이콘
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 6 ||
                            value != userPw) {
                          return '비밀번호가 일치하지 않습니다.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userCPw = value!;
                      },
                      onChanged: (value) {
                        userCPw = value;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: 'Confirm PW', // 입력 필드 위에 표시될 라벨 텍스트
                          hintText: '비빌번호를 재입력하세요', // 입력 필드에 힌트로 표시될 텍스트
                          prefixIcon:
                              const Icon(Icons.key), // 입력 필드 왼쪽에 표시될 아이콘
                          suffixIcon:
                              const Icon(Icons.clear), // 입력 필드 오른쪽에 표시될 아이콘
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16)),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 290,
                        child: ElevatedButton(
                          onPressed: () async {
                            _tryValidation();
                            _fetchData();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      isLoading
                          ? const CircularProgressIndicator()
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
