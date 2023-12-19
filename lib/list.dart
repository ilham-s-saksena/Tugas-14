import 'package:flutter/material.dart';
import 'api_service.dart';

class DisplayImage extends StatefulWidget {
  @override
  _DisplayImageState createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      final users = await ApiService.getUsers();
      setState(() {
        _users = users;
      });
    } catch (e) {
      print('Failed to get users on init. Error: $e');
      // Handle user fetching failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Images'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final imgInfo = _users[index];
          final url =
              "http://10.10.24.15/flutter_image/uploads/${imgInfo['file_name']}";
          return ListBody(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Card(
                  elevation: 4, // Efek bayangan kartu
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12.0), // Sudut yang dibulatkan
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  url, // Ganti dengan path gambar yang sesuai
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _users[index]['description'] ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      _users[index]['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility), // Tombol Lihat
                              onPressed: () {
                                // Tambahkan logika untuk menampilkan popup Lihat di sini
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit), // Tombol Edit
                              onPressed: () {
                                // Tambahkan logika untuk menampilkan popup Edit di sini
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete), // Tombol Hapus
                              onPressed: () {
                                // Tambahkan logika untuk menampilkan popup Hapus di sini
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
