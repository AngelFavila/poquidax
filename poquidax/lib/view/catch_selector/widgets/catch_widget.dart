import 'package:flutter/material.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';

class CatchWidget extends StatefulWidget {
  final Size screenSize;
  final CatchSelectorViewModel viewModel; // Add the ViewModel as a parameter

  CatchWidget({required this.screenSize, required this.viewModel});

  @override
  _CatchState createState() => _CatchState();
}

class _CatchState extends State<CatchWidget> {
  final controller = TextEditingController(); // Controller for the search bar
  @override
  void initState() {
    super.initState();
  }

  // Widget to build each menu item
  Widget _catchItem(int index, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.viewModel.setSelectedIndex(index); // Update the ViewModel
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          width: double.infinity,
          color: widget.viewModel.selectedIndex == index
              ? Colors.yellow
              : Colors.white,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenSize.width,
      height: widget.screenSize.height,
      color: Colors.white,
      child: SingleChildScrollView(
          child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Pokemon Name',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ),
      )),
    );
  }
}
