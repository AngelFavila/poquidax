import 'package:flutter/material.dart';
import 'package:pokedax/providers/pokedex_provider.dart';
import 'package:pokedax/view/helpers/string_helper.dart';
import 'package:pokedax/viewmodel/catch_selector_viewmodel.dart';
import 'package:pokedax/viewmodel/selector_viewmodel.dart';
import 'package:provider/provider.dart';

class SelectorWidget extends StatefulWidget {
  SelectorWidget();

  @override
  _SelectorState createState() => _SelectorState();
}

class _SelectorState extends State<SelectorWidget> with StringHelper {
  final controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<PokedexProvider>().viewModel as SelectorViewModel;
    final screenSize = MediaQuery.of(context).size;

    // Scroll to the focused index if necessary
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.focusedIndex != -1) {
        _scrollToIndex(viewModel.focusedIndex, itemHeight: screenSize.width*.12);
      }
    });

    return Container(
      width: screenSize.width*.8,
      height: screenSize.height,
      color: Colors.white,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: SearchBarWidget()),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.filteredPokemons.length,
              itemBuilder: (context, index) {
                final pokemon = viewModel.filteredPokemons[index];

                return SizedBox(
                  height: screenSize.width*.12,
                  child: GestureDetector(
                    onTap: () {
                      viewModel.selectPokemon(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: viewModel.focusedIndex == index
                            ? Colors.yellow
                            : Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(formatAsTitle(pokemon.name)),
                        contentPadding: EdgeInsets.all(16), // Adjust padding as needed
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  TextField SearchBarWidget() {
    final viewModel = context.read<PokedexProvider>().viewModel as SelectorViewModel;

    return TextField(
      controller: controller,
      onChanged: (text) {
        viewModel.filterPokemons(controller.text);
      },
      decoration: InputDecoration(
          hintText: 'Nombre de Pokemon',
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: Icon(Icons.search)),
    );
  }

  void _scrollToIndex(int index, {double itemHeight = 60.0}) {
  double offset = itemHeight * index; 
  
  _scrollController.animateTo(
    offset,
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );
}

}
