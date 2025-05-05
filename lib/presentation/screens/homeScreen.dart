import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:terefbooking/data/constants.dart';
import 'package:terefbooking/presentation/customeWidgets/drawer.dart';
import 'package:terefbooking/presentation/screens/turfDetailsScreen.dart';
import 'package:terefbooking/services/getTurfsApi.dart';

class HomeScreen extends StatefulWidget {
 

  const HomeScreen({Key? key,}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredTurfs = [];
   List<dynamic>dTurfs = [];

  @override
  void initState() {
    super.initState();
    // filteredTurfs = dTurfs; // Initially, all turfs are shown.
    searchController.addListener(_performSearch);
    turfget();
  }

  void turfget()async{
     dTurfs = await getTurfs();
     setState(() {
       filteredTurfs = dTurfs;
     });
  }

  void _performSearch() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredTurfs = dTurfs.where((turf) {
        final name = turf['turfname']?.toLowerCase() ?? '';
        final location = turf['location']?.toLowerCase() ?? '';
        return name.contains(query) || location.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Pitch Time',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appthemeColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 35,
              child: CupertinoSearchTextField(
                controller: searchController,
                placeholder: 'Search by name or location',
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: filteredTurfs.isEmpty
                  ? const Center(
                      child: Text('No turfs found matching your search.'),
                    )
                  : ListView.builder(
                      itemCount: filteredTurfs.length,
                      itemBuilder: (context, index) {
                        final turf = filteredTurfs[index];
                        return TurfCard(turf: turf);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class TurfCard extends StatelessWidget {
  final dynamic turf;

  const TurfCard({
    Key? key,
    required this.turf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TurfDetailsScreen(
              turfid: turf['id'],
              name: turf['turfname'],
              place: turf['location'] ?? "Not available",
              rent: turf['rent'].toString(),
              image: '$baseUrl/${turf['image']}',
              rating: turf['rating'] ?? '0',
              description: turf['address'] ?? "Not available",
              openingTime: turf['opentime'].toString(),
              closingTime: turf['closingtime'].toString(),
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    '$baseUrl/${turf['image']}',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.black.withOpacity(0.7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            turf['rating'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    turf['turfname'] ?? "Not available",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    turf['location'] ?? "Not available",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    turf['rent'].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
