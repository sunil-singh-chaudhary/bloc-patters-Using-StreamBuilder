import 'package:bloc_patter_demo_2/DataBloc.dart';
import 'package:flutter/material.dart';

class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final _bloc = DataBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.data,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("ERROR"));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].title),
                subtitle: Text(snapshot.data![index].subtitle),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _bloc.fetchData,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
