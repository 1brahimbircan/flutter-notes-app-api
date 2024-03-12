import 'package:flutter/material.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/utils/date_time_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AccordionCard extends StatefulWidget {
  const AccordionCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<AccordionCard> createState() => _AccordionCardState();
}

class _AccordionCardState extends State<AccordionCard>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isExpanded = !isExpanded),
      child: AnimatedContainer(
        duration: isExpanded == true
            ? const Duration(seconds: 1)
            : const Duration(milliseconds: 300),
        curve: isExpanded == true
            ? Curves.fastLinearToSlowEaseIn 
            : Curves.fastOutSlowIn,
        height: isExpanded ? 100 + _calculateExpandedHeight(context) : 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _cardColorDefine(widget.note.priority!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriorityLine(widget.note.priority!),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityLine(String priority) {
    return Container(
      width: 15,
      decoration: BoxDecoration(
        color: _priorityColorDefine(priority),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          bottomLeft: Radius.circular(5),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHeaderRow(context),
            if (isExpanded) _buildExpandedContent(),
          ],
        ),
      ),
    );
  }

  Row _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateTimeUtils.instance
                  .dateFormat(widget.note.dateadded!),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w100),
            ),
            Text(
              widget.note.title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              widget.note.category!,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: _priorityColorDefine(widget.note.priority!),
              ),
            ),
          ],
        ),
        Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
      ],
    );
  }

  Widget _buildExpandedContent() {
    return Column(
      children: [
        const Divider(color: Colors.grey),
        Text(
          widget.note.content!,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

double _calculateExpandedHeight(BuildContext context) {
  final text = widget.note.content!;
  final textStyle = GoogleFonts.inter(fontWeight: FontWeight.w300, fontSize: 15);
  final textSpan = TextSpan(text: text, style: textStyle);
  
  final maxWidth = MediaQuery.of(context).size.width -100 ; // Adjusted width for padding
  final textPainter = TextPainter(
    text: textSpan,
    textDirection: TextDirection.ltr,
    maxLines: null,
  );
  
  textPainter.layout(maxWidth: maxWidth);
  return textPainter.height;
}


  Color _cardColorDefine(String oncelik) {
    var renk = Colors.white;
    if (oncelik == "Low") {
      renk = const Color.fromARGB(65, 3, 65, 1);
      return renk;
    } else if (oncelik == "Middle") {
      renk = const Color.fromARGB(65, 65, 65, 1);
      return renk;
    } else if (oncelik == "High") {
      renk = const Color.fromARGB(65, 65, 1, 1);
      return renk;
    }
    return renk;
  }

  Color _priorityColorDefine(String oncelik) {
    var renk = Colors.white;
    if (oncelik == "Low") {
      renk = const Color.fromARGB(255, 0, 255, 9);
      return renk;
    } else if (oncelik == "Middle") {
      renk = Colors.amber;
      return renk;
    } else if (oncelik == "High") {
      renk = Colors.red;
      return renk;
    }
    return renk;
  }
}
