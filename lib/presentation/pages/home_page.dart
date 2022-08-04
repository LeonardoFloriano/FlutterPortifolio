// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:tab_container/tab_container.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int index = 0;
  late bool isExpanded;
  late double extent;
  List<bool> selected = [true, false, false, false, false];

  PageController page = PageController();
  late final TabContainerController _controller;

  @override
  void initState() {
    _controller = TabContainerController(length: 3);
    extent = 125;
    isExpanded = true;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<NavItemInfo> itemsNav = [
    NavItemInfo(Icons.home_filled, 'Home'),
    NavItemInfo(Icons.task, 'Projetos'),
    NavItemInfo(Icons.person, 'Pessoal'),
    NavItemInfo(Icons.phone_callback, 'Contato'),
  ];

  Future<void> select(int n) async {
    for (int i = 0; i < 5; i++) {
      if (i == n) {
        selected[i] = true;
        index = i;
      } else {
        selected[i] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body() {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          backgroundBlendMode: BlendMode.plus,
        ),
        child: PlasmaRenderer(
          type: PlasmaType.infinity,
          particles: 22,
          color: Colors.white,
          blur: 0.32,
          size: 0.77,
          speed: 0.86,
          offset: 2.56,
          blendMode: BlendMode.srcOver,
          particleType: ParticleType.atlas,
          variation1: 0,
          variation2: 0,
          variation3: 0,
          rotation: -0.45,
        ),
      ),
      Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: 150.0,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border:
                      Border(right: BorderSide(width: 2, color: Colors.black))),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: Text(
                            'Leonardo Floriano',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(fontSize: 20, fontFamily: 'arial'),
                          )),
                        ),
                      ),
                      Column(
                        children: itemsNav
                            .map(
                              (e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: NavBarItem(
                                  icon: e.icon,
                                  selected: selected[itemsNav.indexOf(e)],
                                  texto: e.texto,
                                  onTap: () {
                                    setState(() {
                                      select(itemsNav.indexOf(e));
                                    });
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(child: Container(child: Center(child: getBody(index))))
        ],
      )
    ]);
  }
}

getBody(int index) {
  return Text(
    '$index',
    style: TextStyle(color: Colors.amber),
  );
}

class NavItemInfo {
  final String texto;
  final IconData icon;

  NavItemInfo(this.icon, this.texto);
}

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final String texto;
  final Function onTap;
  final bool selected;

  NavBarItem({
    required this.icon,
    required this.onTap,
    required this.texto,
    required this.selected,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  late Animation<double> _anim1;
  late Animation<double> _anim2;
  late Animation<double> _anim3;
  late Animation<Color?> _color;

  bool hovered = false;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );

    _anim1 = Tween(begin: 150.0, end: 150.0).animate(_controller1);
    _anim2 = Tween(begin: 150.0, end: 0.0).animate(_controller2);
    _anim3 = Tween(begin: 150.0, end: 0.0).animate(_controller2);
    _color = ColorTween(end: Colors.white, begin: Colors.black)
        .animate(_controller2);

    _controller1.addListener(() {
      setState(() {});
    });
    _controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(NavBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.selected) {
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller1.reverse();
      });
      _controller1.reverse();
      _controller2.reverse();
    } else {
      _controller1.forward();
      _controller2.forward();
      Future.delayed(Duration(milliseconds: 10), () {
        //_controller2.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: Container(
          width: 150.0,
          color: hovered && !widget.selected
              ? Colors.grey.shade300
              : Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  child: CustomPaint(
                    painter: CurvePainter(
                      value1: 0,
                      animValue1: _anim3.value,
                      animValue2: _anim2.value,
                      animValue3: _anim1.value,
                    ),
                  ),
                ),
              ),
              Container(
                height: 90.0,
                width: 150.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        widget.icon,
                        color: _color.value,
                        size: 30.0,
                      ),
                      SizedBox(width: 15),
                      Text(
                        widget.texto,
                        style: TextStyle(fontSize: 18, color: _color.value),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value1; // 200
  final double animValue1; // static value1 = 50.0
  final double animValue2; //static value1 = 75.0
  final double animValue3; //static value1 = 75.0

  CurvePainter({
    required this.value1,
    required this.animValue1,
    required this.animValue2,
    required this.animValue3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    path.moveTo(150, value1);
    path.lineTo(animValue1, value1);
    path.lineTo(animValue1, value1 + 90);
    path.lineTo(150, value1 + 90);

    paint.color = Colors.black;
    paint.strokeWidth = 150.0;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
