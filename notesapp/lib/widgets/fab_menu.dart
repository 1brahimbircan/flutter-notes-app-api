import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notesapp/pages/note_add_page.dart';


class FABMenu extends StatefulWidget {
  const FABMenu({super.key});

  @override
  State<FABMenu> createState() => _FABMenuState();
}

class _FABMenuState extends State<FABMenu> with SingleTickerProviderStateMixin {
  bool toggle = true;
  Alignment alignment1 = const Alignment(1.0, 0.0);
  Alignment alignment2 = const Alignment(1.0, 0.0);
  Alignment alignment3 = const Alignment(1.0, 0.0);
  Alignment alignment4 = const Alignment(1.0, 0.0);
  double size1 = 45.0;

  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
      reverseCurve: Curves.linear,
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        height: 60,
        width: toggle ? 60 : 320.0,
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(25)),
        child: Stack(children: [
          animatedCircleButton(
            alignment: alignment1,
            size: size1,
            icon: const Icon(Icons.post_add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NoteAddPage(isUpdate: false),
              ));
            },
          ),
          animatedCircleButton(
            alignment: alignment2,
            size: size1,
            icon: const Icon(Icons.library_add),
            onPressed: () {},
          ),
          animatedCircleButton(
            alignment: alignment3,
            size: size1,
            icon: const Icon(Icons.library_add),
            onPressed: () {},
          ),
          animatedCircleButton(
            alignment: alignment4,
            size: size1,
            icon: const Icon(Icons.chat_bubble),
            onPressed: () {},
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.rotate(
              angle: _animation.value * pi * (3 / 4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 375),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(60)),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                      iconSize: 40,
                      splashColor: Colors.black54,
                      splashRadius: 31.0,
                      onPressed: () {
                        setState(() {
                          if (toggle) {
                            toggle = !toggle;
                            _controller.forward();
                            Future.delayed(
                              const Duration(milliseconds: 10),
                              () {
                                alignment1 = const Alignment(-0.7, 0.0);
                                alignment2 = const Alignment(-0.3, 0.0);
                                alignment3 = const Alignment(0.1, 0.0);
                                alignment4 = const Alignment(0.5, 0.0);
                                size1 = 50.0;
                              },
                            );
                          } else {
                            toggle = !toggle;
                            _controller.reverse();
                            alignment1 = const Alignment(1.0, 0.0);
                            alignment2 = const Alignment(1.0, 0.0);
                            alignment3 = const Alignment(1.0, 0.0);
                            alignment4 = const Alignment(1.0, 0.0);
                            size1 = 45.0;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  AnimatedAlign animatedCircleButton(
      {required Alignment alignment,
      required double size,
      required Icon icon,
      required Function() onPressed}) {
    return AnimatedAlign(
      duration: toggle
          ? const Duration(milliseconds: 275)
          : const Duration(milliseconds: 875),
      alignment: alignment,
      curve: toggle ? Curves.linear : Curves.fastOutSlowIn,
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 275),
          curve: toggle ? Curves.easeIn : Curves.easeOut,
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: IconButton(onPressed: onPressed, icon: icon)),
    );
  }
}
