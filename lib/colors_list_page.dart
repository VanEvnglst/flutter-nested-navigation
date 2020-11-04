import 'package:flutter/material.dart';

class ColorsListPage extends StatelessWidget {
  final MaterialColor color;
  final String title;
  final ValueChanged<int> onPush;

  ColorsListPage({Key key, this.color, this.title, this.onPush}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        backgroundColor: color,
      ),
      body: Container(
        color: Colors.white,
        child: _buildList(),
      ),
    );
  }

  final List<int> materialIndices = [900, 800, 700, 600, 500, 400, 300, 200, 100, 50];

  Widget _buildList() {
    print('build list');
    return ListView.builder(
      itemCount: materialIndices.length,
      itemBuilder: (BuildContext context, int index) {
        int materialIndex = materialIndices[index];
        return Container(
          color: color[materialIndex],
          child: ListTile(
            title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
            trailing: Icon(Icons.chevron_right),
            onTap: () => onPush(materialIndex),
          ),
        );
      },
    );
  }
}