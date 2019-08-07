import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:edukasi_pot/models/models.dart';
import 'package:edukasi_pot/providers/providers.dart';
import 'package:edukasi_pot/screens/screens.dart';
import 'package:edukasi_pot/widgets/widgets.dart';

class SubjectScreen extends StatelessWidget {
  static const routeName = '/subject';

  final Subject subject;

  const SubjectScreen({this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00716B),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _ClassBanner(
                subjectId: subject.id,
                klassName: subject.klass,
              ),
              _SubjectInfo(
                subjectId: subject.id,
                subjectName: subject.name,
                startTime: subject.startTime,
                endTime: subject.endTime,
              ),
              _Subject(subjectId: subject.id)
            ],
          ),
        ),
      ),
    );
  }
}

class _Subject extends StatelessWidget {
  final int subjectId;

  const _Subject({@required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Continue
        Container(
          width: 300.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(9.0, 8.0),
                  blurRadius: 16.0,
                  spreadRadius: 4.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, ModuleScreen.routeName),
              borderRadius: BorderRadius.circular(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50.0,
          child: Center(
            child: Text(
              'or',
              style: TextStyle(
                color: Color(0xFF54B9A6),
              ),
            ),
          ),
        ),
        // Choose schedules
        Container(
          width: 300.0,
          decoration: BoxDecoration(
            color: Color(0xFFDBE7F9),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(9.0, 8.0),
                  blurRadius: 16.0,
                  spreadRadius: 4.0),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                var _list =
                    await Provider.of<SubjectProvider>(context, listen: false)
                        .subjectList;
                Navigator.of(context).pushReplacementNamed(
                    SubjectListScreen.routeName,
                    arguments: RouteArgument(
                        from: SubjectScreen.routeName, obj: _list));
              },
              borderRadius: BorderRadius.circular(16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Choose Schedules',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFF5771AD),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 50.0)
      ],
    );
  }
}

class _SubjectInfo extends StatelessWidget {
  final int subjectId;
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;

  final String nameTag;

  const _SubjectInfo(
      {Key key,
      @required int this.subjectId,
      @required String this.subjectName,
      @required DateTime this.startTime,
      @required DateTime this.endTime})
      : nameTag = '$subjectId:$subjectName',
        super(key: key);

  String _time_info() {
    final startHm = DateFormat.Hm().format(startTime);
    final endHm = DateFormat.Hm().format(endTime);

    final diffMin = endTime.difference(startTime).inMinutes;
    return '$startHm ~ $endHm ($diffMin Mins)';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// Upcoming class text
          Text(
            _time_info(),
            style: TextStyle(
              color: Color(0xFF54B9A6),
              fontSize: 24.0,
            ),
          ),
          SizedBox(height: 24.0),

          /// Subject text
          Hero(
              tag: nameTag,
              child: Material(
                color: Colors.transparent,
                child: GradientText(
                  text: subjectName,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE9FCD8),
                      Color(0xFFC6EDF8),
                    ],
                  ),
                  style: TextStyle(
                      color: Color(0xFFE9FCD9),
                      fontSize: 90.0,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ],
      ),
    );
  }
}

class _ClassBanner extends StatelessWidget {
  final int subjectId;
  final String klassName;
  final String klassTag;

  const _ClassBanner(
      {Key key, @required this.subjectId, @required String this.klassName})
      : klassTag = '$subjectId:$klassName',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BannerClipper(),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFFFF5B30),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Center(
          child: Hero(
            tag: klassTag,
            child: Material(
              color: Colors.transparent,
              child: Text(
                klassName,
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: MediaQuery.of(context).size.height * 8 / 9.5,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            )),
        child: Text('List'),
      ),
    );
  }
}
