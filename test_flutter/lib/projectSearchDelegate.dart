import 'package:flutter/material.dart';

class ProjectSearchDelegate extends SearchDelegate {
  static final List<Map<String, dynamic>> _projects = [
    {
      'id': 'P001',
      'name': 'Website Development',
      'status': 'Ongoing',
      'progress': 70,
    },
    {
      'id': 'P002',
      'name': 'Mobile App Design',
      'status': 'Completed',
      'progress': 100,
    },
    {
      'id': 'P003',
      'name': 'Digital Marketing Campaign',
      'status': 'Pending',
      'progress': 0,
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the search bar, such as clearing the search query
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon (e.g., back button)
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search delegate
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display search results
    final searchResults = _projects.where((project) {
      return project['name'].toLowerCase().contains(query.toLowerCase()) ||
          project['id'].toLowerCase().contains(query.toLowerCase()) ||
          project['status'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final project = searchResults[index];
        return ListTile(
          title: Text(project['name']),
          subtitle: Text('Status: ${project['status']}'),
          onTap: () {
            // Navigate to project details screen
            Navigator.pushNamed(
              context,
              '/project-detail',
              arguments: project,
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions while the user types in the search bar
    final searchSuggestions = _projects.where((project) {
      return project['name'].toLowerCase().contains(query.toLowerCase()) ||
          project['id'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: searchSuggestions.length,
      itemBuilder: (context, index) {
        final project = searchSuggestions[index];
        return ListTile(
          title: Text(project['name']),
          subtitle: Text('Status: ${project['status']}'),
          onTap: () {
            query = project['name']; // Set the query to the selected project name
            showResults(context); // Show results for the selected project
          },
        );
      },
    );
  }
}
