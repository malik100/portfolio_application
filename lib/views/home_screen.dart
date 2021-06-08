import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio_app/models/github_profile.dart';
import 'package:portfolio_app/services/services.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String githubname;

  HomeScreen(String githubname) {
    this.githubname = githubname;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState(githubname);
}

class _HomeScreenState extends State<HomeScreen> {
  String githubname;
  _HomeScreenState(String name) {
    this.githubname = name;
  }

  GithubProfile profile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });

    var url = "https://api.github.com/users/" + githubname;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      profile = GithubProfile.fromJson(json.decode(response.body));
      setState(() {
        profile = GithubProfile.fromJson(json.decode(response.body));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main scherm gedeelte
      body: getBody(context),
      drawer: getDrawer(context),
      floatingActionButton: getFloatingActionButton(context),
    );
  }

  Widget getBody(context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.orange,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      );
    }
    return Stack(
      children: [
        Image.asset(
          'images/background.jpg',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black54,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.teal[200],
                        backgroundImage: AssetImage("images/ben.jpg"),
                        foregroundColor: Color.fromARGB(70, 10, 20, 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: [
                            Text(
                              'MALIK',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'YURTBILIR',
                              style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  profile.location,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.orange,
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.monitor,
                      size: 40,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Text(
                          'Dart',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'VueJs',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.stay_current_portrait,
                      size: 40,
                      color: Colors.white,
                    ),
                    Column(
                      children: [
                        Text(
                          'C#',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Java',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.laptop_mac,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.orange,
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Public Projects:',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              profile.reposcount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Public Gists:',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              profile.gistscount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.orange,
                  height: 20,
                  thickness: 5,
                  indent: 0,
                  endIndent: 0,
                ),
                Text(
                  'About me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'I am an software developer living in Amsterdam' +
                        'I use dart flutter framework for mobile apps. and VueJS for web applications.' +
                        'For desktop development i am using Java and C#. I try always to learn new Languages and techniques',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget getDrawer(context) {
    return Drawer(
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/repos');
                },
                child: Text(
                  'Repos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  //dialogBeforeSendingToUrl('https://www.instagram.com/maliknl50', context);
                  dialogBeforeSendingToUrl(
                      'https://www.instagram.com/' + profile.instagram,
                      context);
                },
                child: Text(
                  'Instagram',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dialogBeforeSendingToUrl(
                      'https://twitter.com/' + profile.getTwitter(), context);
                },
                child: Text(
                  'Twitter',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dialogBeforeSendingToUrl(
                      'https://' + profile.getSite(), context);
                },
                child: Text(
                  'Website',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getFloatingActionButton(context) {
    return FloatingActionButton(
      child: Icon(Icons.qr_code),
      backgroundColor: Colors.orange,
      onPressed: () {
        Navigator.pushNamed(context, '/qr');
      },
    );
  }
}
