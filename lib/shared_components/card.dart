import 'package:flutter/material.dart';

import 'colors.dart';

class GradientCard extends StatefulWidget {
  const GradientCard(
      {Key? key,
      this.colorBegin,
      this.colorCenter,
      this.colorEnd,
      this.title,
      this.subtitle,
      this.actionWidget,
      this.topIcon,
      this.bottomIcon,
      this.textStyle})
      : super(key: key);
  final Color? colorBegin;
  final Color? colorCenter;
  final Color? colorEnd;
  final String? title;
  final String? subtitle;
  final Widget? topIcon;
  final Widget? bottomIcon;
  final Widget? actionWidget;
  final TextStyle? textStyle;
  @override
  _GradientCardState createState() => _GradientCardState();
}


class _GradientCardState extends State<GradientCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              top: 0,
              bottom: 10,
              child: Card(
                  elevation: 0,
                  color: const Color(0xffcde0ff),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34)),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width - 110,
                      height: 300))),
          Positioned(
              top: 0,
              bottom: 18,
              child: Card(
                  elevation: 0,
                  color: const Color(0xff90bafe),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 300,
                  ))),
          Positioned(
            top: 0,
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: const Alignment(-1, -1),
                      end: const Alignment(0, -2),
                      colors: [
                        Colors_().primary,
                        Colors_().primary.withOpacity(0.5),
                        Colors_().primary,
                      ]),
                  borderRadius: const BorderRadius.all(Radius.circular(34))),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(widget.title.toString(),style: const TextStyle(color: Colors.white),)),
                            InkWell(
                              onTap: (){
                                _showOverlay(context);
                              },
                              child: Row(
                                children: const[
                                  Text("Inbox",style:  TextStyle(color: Colors.white),),
                                   SizedBox(width: 12,),

                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Text(
                                        widget.subtitle.toString(),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.9),
                                            fontSize: 16),
                                      )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              child: widget.actionWidget,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xffffffff)
                                      .withOpacity(0.8)
                                      .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20)),
                            )
                          ]
                        )
                      ),
                      Container(
                        child: widget.bottomIcon,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xffcde0ff).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(
                        width: 24,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ])));
  }

  void _showOverlay(context) async {
    GlobalKey _key = GlobalKey();
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: offset.dy - 40,
        left: offset.dx - 120,
        child: _buildInfo(),
      ),
    );

    Overlay.of(context)!.insert(entry);
    await Future.delayed(const Duration(seconds: 4));
    entry.remove();
  }

  Widget _buildInfo() {
    return Material(
      child: Container(
        color: Colors.red[200],
        padding: const EdgeInsets.all(12),
        child: const Text('This is an info button'),
      ),
    );
  }
}
