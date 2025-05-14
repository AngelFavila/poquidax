import 'package:flutter/material.dart';

class PokemonImageLoader extends StatefulWidget {
  final String imageUrl;
  const PokemonImageLoader({required this.imageUrl, super.key});

  @override
  State<PokemonImageLoader> createState() => _PokemonImageLoaderState();
}

class _PokemonImageLoaderState extends State<PokemonImageLoader> {
  int _stage = 0; // 0 = gif, 1 = white, 2 = yellow, 3 = sprite
  bool _hasPrecached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasPrecached) {
      _hasPrecached = true;

      precacheImage(AssetImage('assets/animations/pokeball.gif'), context)
          .then((_) {
        Future.delayed(Duration(milliseconds: 1400), () {
          setState(() => _stage = 1);
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() => _stage = 2);
            Future.delayed(Duration(milliseconds: 100), () {
              setState(() => _stage = 3);
              Future.delayed(Duration(milliseconds: 100), () {
                setState(() => _stage = 4);
                Future.delayed(Duration(milliseconds: 100), () {
                  setState(() => _stage = 5);
                });
              });
            });
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (_stage) {
      case 0:
        content =
            Image.asset('assets/animations/pokeball.gif', fit: BoxFit.contain);
        break;
      case 1:
        content = Container(color: Colors.white);
        break;
      case 2:
        content = Container(color: Colors.yellow);
        break;
      case 3:
        content = Container(color: Colors.orange);
        break;
      case 4:
        content = Container(color: Colors.yellow);
        break;
      default:
        content = Image.network(widget.imageUrl, fit: BoxFit.contain);
    }

    return SizedBox.expand(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: SizedBox.expand(child: content),
      ),
    );
  }
}
