import 'package:flutter/material.dart';
import 'package:votely/model/choice_model.dart';
import 'package:votely/repository/auth_repository.dart';
import 'package:votely/repository/data_repository.dart';

class VoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: <Widget>[
          Text(
            "Vote For Your Favorite Programming Language!",
            style: Theme.of(context).textTheme.headline,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("You can only vote once for each language."),
          SizedBox(
            height: 35.0,
          ),
          StreamBuilder<List<ChoiceModel>>(
            stream: DataRepository().choices(),
            builder: _builder,
          ),
          SizedBox(
            height: 35.0,
          ),
          FlatButton(
            child: Text("Log out"),
            onPressed: logout,
          )
        ],
      ),
    ));
  }

  Widget _builder(
      BuildContext context, AsyncSnapshot<List<ChoiceModel>> snapshot) {
    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
    snapshot.data.sort(sorter);
    return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children:
            snapshot.data.map((choice) => _ChoiceTile(model: choice)).toList());
  }

  int sorter(d1, d2) => d2.count.compareTo(d1.count);

  void logout() {
    AuthRepository().signOut();
  }
}

class _ChoiceTile extends StatelessWidget {
  final ChoiceModel model;

  const _ChoiceTile({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${model.name}"),
        trailing: CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.blueAccent,
            child: Text("${model.count}")),
        onTap: vote,
      ),
    );
  }

  void vote() => DataRepository().voteForChoice(model.id);
}
