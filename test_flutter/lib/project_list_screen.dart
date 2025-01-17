import 'package:flutter/material.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({Key? key}) : super(key: key);

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final List<Map<String, dynamic>> _projects = [
    {
      'id': 'P001',
      'name': 'Website Development',
      'status': 'Ongoing',
      'progress': 70,
      'milestones': [
        {'name': 'Requirement Gathering', 'date': '2025-01-01', 'completed': true},
        {'name': 'Design Phase', 'date': '2025-01-05', 'completed': true},
        {'name': 'Development Phase', 'date': '2025-01-10', 'completed': false},
      ],
    },
    {
      'id': 'P002',
      'name': 'Mobile App Design',
      'status': 'Completed',
      'progress': 100,
      'milestones': [
        {'name': 'Wireframe Creation', 'date': '2025-01-01', 'completed': true},
        {'name': 'Prototype Design', 'date': '2025-01-05', 'completed': true},
        {'name': 'Final Review', 'date': '2025-01-08', 'completed': true},
      ],
    },
    {
      'id': 'P003',
      'name': 'Digital Marketing Campaign',
      'status': 'Pending',
      'progress': 0,
      'milestones': [
        {'name': 'Strategy Planning', 'date': '2025-01-15', 'completed': false},
        {'name': 'Content Creation', 'date': '2025-01-20', 'completed': false},
        {'name': 'Launch Campaign', 'date': '2025-01-25', 'completed': false},
      ],
    },
  ];

  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProjects = _selectedFilter == 'All'
        ? _projects
        : _projects.where((project) => project['status'] == _selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All')),
              const PopupMenuItem(value: 'Ongoing', child: Text('Ongoing')),
              const PopupMenuItem(value: 'Completed', child: Text('Completed')),
              const PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredProjects.isEmpty
            ? const Center(
          child: Text(
            'No projects available.',
            style: TextStyle(fontSize: 18),
          ),
        )
            : ListView.builder(
          itemCount: filteredProjects.length,
          itemBuilder: (context, index) {
            final project = filteredProjects[index];
            return ProjectCard(
              project: project,
              onViewDetails: () {
                Navigator.pushNamed(
                  context,
                  '/project-detail',
                  arguments: project,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Map<String, dynamic> project;
  final VoidCallback onViewDetails;

  const ProjectCard({
    Key? key,
    required this.project,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: project['status'] == 'Ongoing'
              ? Colors.blue
              : project['status'] == 'Completed'
              ? Colors.green
              : Colors.orange,
          child: Text(
            project['id'].substring(1),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(project['name']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${project['status']}'),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: project['progress'] / 100,
              backgroundColor: Colors.grey[300],
              color: project['status'] == 'Ongoing'
                  ? Colors.blue
                  : project['status'] == 'Completed'
                  ? Colors.green
                  : Colors.orange,
            ),
          ],
        ),
        trailing: TextButton(
          onPressed: onViewDetails,
          child: const Text('View Details'),
        ),
      ),
    );
  }
}
