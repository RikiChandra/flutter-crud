import 'package:flutter/material.dart';
import 'package:medical_app/model/obat_model.dart';
import 'package:medical_app/util/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({Key? key}) : super(key: key);

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  List<Obat> obat = [];
  bool isLoading = false;
  int currentIndex = 0;

  TextEditingController namaCon = TextEditingController();
  TextEditingController hargaCon = TextEditingController();
  TextEditingController satuanCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      _getObat(token);
    }
  }

  Future<void> _getObat(String accessToken) async {
    setState(() {
      isLoading = true;
    });
    final result = await ApiConfig().getObat(accessToken);
    setState(() {
      obat = result.data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _listData(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          formData(null);
        },
        label: const Text('Tambah Obat'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void formData(Obat? data) async {
    if (data != null) {
      namaCon.text = data.nama;
      hargaCon.text = data.harga.toString();
      satuanCon.text = data.satuan;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data == null ? 'Tambah Obat' : 'Ubah Obat'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: namaCon,
                  decoration: const InputDecoration(labelText: 'Nama Obat'),
                ),
                TextFormField(
                  controller: hargaCon,
                  decoration: const InputDecoration(labelText: 'Harga'),
                  keyboardType: TextInputType.number, // Input numerical data
                ),
                TextFormField(
                  controller: satuanCon,
                  decoration: const InputDecoration(labelText: 'Satuan'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => _store(data),
              child: Text(data == null ? 'Simpan' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _store(Obat? data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');
      if (token != null) {
        if (data != null) {
          // Update existing record
          await ApiConfig().updateObat(
            token,
            data.id,
            namaCon.text,
            hargaCon.text,
            satuanCon.text,
          );
        } else {
          // Create new record
          await ApiConfig().storeObat(
            token,
            namaCon.text,
            hargaCon.text,
            satuanCon.text,
          );
          namaCon.clear();
          hargaCon.clear();
          satuanCon.clear();
        }

        // Close dialog and refresh data
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        _getObat(token);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _delete(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token != null) {
      await ApiConfig().deleteObat(token, id);
      _getObat(token);
    }
  }

  GridView _listData() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: obat.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => formData(obat[index]),
          child: Card(
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  obat[index].nama,
                  style: const TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Rp ${obat[index].harga.toString()}',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    //make showDialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text('Apakah Anda yakin?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _delete(obat[index].id);
                                Navigator.pop(context);
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              child: Image.network(
                "https://d2qjkwm11akmwu.cloudfront.net/products/665462_20-3-2023_14-10-30.webp",
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
