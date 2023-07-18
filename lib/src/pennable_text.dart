import 'package:flutter/material.dart';

class PennableText extends StatefulWidget {
  final TextEditingController textEditingController;
  final Widget suffix;
  final Color textColor;
  final double textSize;
  final double editIconBottomPAdding;
  final Color fillColor;
  final TextStyle textStyle;

  const PennableText({
    super.key,
    required this.textEditingController,
    required this.suffix,
    required this.textColor,
    this.textSize = 13,
    this.editIconBottomPAdding = 6,
    required this.fillColor,
    required this.textStyle,
  });

  @override
  State<PennableText> createState() => _PennableTextState();
}

class _PennableTextState extends State<PennableText> {
  bool isReadOnly = true;
  late String initialText;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    initialText = widget.textEditingController.text;
  }

  @override
  Widget build(BuildContext context) {
    var size = calcTextSize(
      widget.textEditingController.text,
      TextStyle(
        fontSize: widget.textSize,
        color: widget.textColor,
      ),
    );
    print(size.width);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: 30,
                width: size.width + 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: !isReadOnly ? widget.fillColor : Colors.transparent,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              width: size.width + 10,
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                maxLines: 1,
                style: widget.textStyle,
                focusNode: focusNode,
                readOnly: isReadOnly,
                controller: widget.textEditingController,
                onSubmitted: (value) {
                  isReadOnly = true;
                  initialText = widget.textEditingController.text;
                  setState(() {});
                },
                onTapOutside: (event) {
                  widget.textEditingController.value =
                      TextEditingValue(text: initialText);
                  isReadOnly = true;
                  setState(() {});
                },
                decoration: InputDecoration(
                  // contentPadding:
                  //     const EdgeInsets.symmetric(vertical: 17, horizontal: 15),

                  border: UnderlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Spacer(),
            InkWell(
                onTap: () {
                  if (isReadOnly = true) {
                    isReadOnly = false;
                    focusNode.requestFocus();
                    setState(() {});
                  }
                },
                child: widget.suffix),
            SizedBox(
              height: widget.editIconBottomPAdding,
            ),
          ],
        )
      ],
    );
  }

  Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr,
        textScaleFactor: MediaQuery.of(context).textScaleFactor)
      ..layout();
    return textPainter.size;
  }
}
