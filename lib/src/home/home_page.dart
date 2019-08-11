import 'package:flutter/material.dart';
import 'package:flutterandotrends/shared/models/lecture_model.dart';
import 'package:flutterandotrends/src/home/home_bloc.dart';
import 'package:flutterandotrends/src/home/home_module.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeModule.to.bloc<HomeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: StreamBuilder<List<LectureModel>>(
        stream: homeBloc.outLectures,
        builder: (context, snapshot) => Center(
          child: !snapshot.hasData
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text(snapshot.data[index].idLecture.toString()),
                    ),
                    title: Text(snapshot.data[index].name),
                    subtitle: Text(snapshot.data[index].description),
                    trailing: IconButton(
                      icon: Icon(Icons.hdr_weak),
                      onPressed: () {},
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
