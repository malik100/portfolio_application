import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_app/services/services.dart';

// ignore: must_be_immutable
class ReposScreen extends StatefulWidget {
  String githubname;
  ReposScreen(String name) {
    this.githubname = name;
  }
  @override
  _ReposScreenState createState() => _ReposScreenState(githubname);
}

class _ReposScreenState extends State<ReposScreen> {
  String githubname = "";

  _ReposScreenState(String name) {
    this.githubname = name;
  }


  List projects = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchProject();
  }

  fetchProject() async {
     String url = 'https://api.github.com/users/' + githubname + '/repos';
    setState(() {
      isLoading = true;
    });
    // var url2 = Uri.parse('https://api.github.com/users/wendux/repos');
    // deze url gebruik om te laten zien met meerdere projecten omdat ik op mijn eigen github geen genoeg projecten heb.
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        projects = items;
        isLoading = false;
      });
    } else {
      setState(() {
        projects = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repos'),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (projects.contains(null) || projects.length == 0 || isLoading) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.orange,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      );
    }
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return getCard(projects[index]);
        });
  }

  Widget getCard(index) {
    return Card(
      child: Column(
        children: [
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            actions: [
              IconSlideAction(
                icon: Icons.star_border_rounded,
                caption: index['stargazers_count'].toString() + ' Stars',
              ),
              IconSlideAction(
                icon: Icons.account_tree,
                caption: index['forks'].toString() + ' Forks',
              ),
            ],
            actionExtentRatio: 1 / 7,
            child: ListTile(
              title: Row(
                children: [
                  Text(index['name'].toString().firstChars()),
                  SizedBox(width: 20),
                  if (index['language'] != null)
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(5.0)),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          index['language'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                ],
              ),
              subtitle: Text(index['description'].toString()),
              trailing: InkWell(
                onTap: () {
                  dialogBeforeSendingToUrl(index['html_url'], context);
                },
                child: Text('Visit on Github'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension E on String {

  String firstChars() => length > 20 ? substring(0,20) : substring(0,length) ;
}