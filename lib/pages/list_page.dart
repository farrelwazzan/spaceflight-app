
import 'package:flutter/material.dart';

import '../models/spaceflight.dart';
import '../services/spaceflight_service.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  final String menu;

  const ListPage({
    super.key,
    required this.menu,
  });

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final SpaceflightService service = SpaceflightService();

  late Future<List<Spaceflight>> futureData;

  String? selectedAuthor;

  @override
  void initState() {
    super.initState();

    futureData = service.getData(widget.menu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menu),
      ),

      body: FutureBuilder<List<Spaceflight>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          }

          List<Spaceflight> data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }

          // Mengambil daftar author yang unik
          List<String> authors = data
              .map((item) => item.author)
              .toSet()
              .toList();

          // Memfilter data berdasarkan author
          List<Spaceflight> filteredData = selectedAuthor == null
              ? data
              : data.where((item) {
                  return item.author == selectedAuthor;
                }).toList();

          return Column(
            children: [
              // Daftar chip filter
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: selectedAuthor == null,
                      onSelected: (selected) {
                        setState(() {
                          selectedAuthor = null;
                        });
                      },
                    ),

                    const SizedBox(width: 8),

                    ...authors.map((author) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(author),
                          selected: selectedAuthor == author,
                          onSelected: (selected) {
                            setState(() {
                              selectedAuthor = selected ? author : null;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Daftar artikel hasil filter
              Expanded(
                child: ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    Spaceflight item = filteredData[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),

                        leading: SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 35,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),

                        title: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('Author: ${item.author}'),
                        ),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                item: item,
                                type: widget.menu,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
