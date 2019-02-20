import 'package:flutter/material.dart';
import 'package:spike_flutter_material_theming/backdrop.dart';
import 'package:spike_flutter_material_theming/buttons.dart';
import 'package:spike_flutter_material_theming/forms.dart';
import 'package:spike_flutter_material_theming/labels.dart';
import 'package:spike_flutter_material_theming/lists.dart';
import 'package:spike_flutter_material_theming/my_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme.data,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDemoDialog<String>(
                  context: context,
                  child: AlertDialog(content: Text("aaaaaaaaa"), actions: <Widget>[
                    FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.pop(context, "cancel");
                        }),
                    OutlineButton(
                      child: const Text('NO'),
                      onPressed: () {
                        Navigator.pop(context, "no");
                      },
                    ),
                    RaisedButton(
                      textTheme: Theme.of(context).buttonTheme.textTheme,
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context, "ok");
                      },
                    )
                  ]));
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BackdropPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ButtonsPage(),
          FormsPage(),
          ListsPage(),
          LabelsPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text("ボタン"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            title: Text("フォーム"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text("リスト"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_color_text),
            title: Text("ラベル"),
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('You selected: $value')));
      }
    });
  }
}
