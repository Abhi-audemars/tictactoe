// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _colorTween = ColorTween(begin: Colors.yellow, end: Colors.pink)
        .animate(_animationController);
    _animationController.repeat(reverse: true);
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: _colorTween.value,
            spreadRadius: 2,
            blurRadius: 5,
          )
        ]),
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: _colorTween.value,
            minimumSize: Size(MediaQuery.of(context).size.width, 50),
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.tourney(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
