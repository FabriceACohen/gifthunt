import 'package:flutter/material.dart';

class MultiChoiceQuestionWidget extends StatefulWidget {
  final String question;
  final List<String> options;
  final List<String> initialSelection;
  final ValueChanged<List<String>> onSelectionChanged;

  const MultiChoiceQuestionWidget({
    super.key,
    required this.question,
    required this.options,
    required this.initialSelection,
    required this.onSelectionChanged,
  });

  @override
  State<MultiChoiceQuestionWidget> createState() => _MultiChoiceQuestionWidgetState();
}

class _MultiChoiceQuestionWidgetState extends State<MultiChoiceQuestionWidget> {
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    _selectedOptions = List.from(widget.initialSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                final option = widget.options[index];
                final isSelected = _selectedOptions.contains(option);
                return Card(
                  elevation: isSelected ? 4 : 1,
                  child: ListTile(
                    title: Text(option),
                    trailing: isSelected ? const Icon(Icons.check_circle) : null,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedOptions.remove(option);
                        } else {
                          _selectedOptions.add(option);
                        }
                        widget.onSelectionChanged(_selectedOptions);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}