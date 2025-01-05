import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // For API calls using Dio

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio(); // Initialize Dio instance
  List<String> _results = [];
  bool _isLoading = false;

  Future<void> _search(String query) async {
    setState(() {
      _isLoading = true;
    });

    // Replace with your API endpoint
    final String url = 'http://192.168.1.25:8000/search';

    try {
      final response = await _dio.get(url, data: {'data': query});
      print(response.data);

      if (response.statusCode == 200) {
        // Assuming API returns a JSON array of strings
        final List<dynamic> data = response.data;
        setState(() {
          _results = List<String>.from(data);
        });
      } else {
        setState(() {
          _results = [];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } on DioError catch (e) {
      setState(() {
        _results = [];
      });

      String errorMessage = 'Error fetching data';
      if (e.response != null) {
        errorMessage = 'Error: ${e.response?.statusCode}';
      } else {
        errorMessage = e.message ?? 'Unknown error occurred';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      setState(() {
        _results = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unexpected error occurred')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) => _search(value), // Trigger search on Enter key
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _search(_searchController.text),
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (_isLoading) const CircularProgressIndicator(),
            if (!_isLoading && _results.isEmpty)
              const Text('No results found.'),
            if (!_isLoading && _results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_results[index]),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
