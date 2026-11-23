import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationEntry {
  const EducationEntry({
    required this.institution,
    required this.degree,
    required this.startYear,
    required this.endYear,
    required this.description,
  });

  final String institution;
  final String degree;
  final String startYear;
  final String endYear;
  final String description;
}

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<EducationEntry> _entries = [
    const EducationEntry(
      institution: 'Universitas Indonesia',
      degree: 'Sarjana Ilmu Komputer',
      startYear: '2025',
      endYear: 'Sekarang',
      description:
          'Mempelajari ilmu komputer dan pengembangan perangkat lunak.',
    ),
  ];

  Future<void> _addEducation() async {
    final entry = await Navigator.push<EducationEntry>(
      context,
      MaterialPageRoute(builder: (_) => const EducationFormPage()),
    );
    if (entry != null && mounted) {
      setState(() => _entries.insert(0, entry));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Pendidikan berhasil ditambahkan.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education')),
      body: _entries.isEmpty
          ? const Center(child: Text('Belum ada riwayat pendidikan.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _entries.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.institution,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.degree,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text('${entry.startYear} – ${entry.endYear}'),
                        if (entry.description.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(entry.description),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addEducation,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Pendidikan'),
      ),
    );
  }
}

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _institution = '';
  String _degree = '';
  String _startYear = '';
  String _endYear = '';
  String _description = '';

  String? _validateYear(String? value) {
    if (value == null || value.trim().isEmpty) return 'Tahun wajib diisi.';
    if (value.trim().toLowerCase() == 'sekarang') return null;
    final year = int.tryParse(value.trim());
    if (year == null || year < 1900 || year > 2100) {
      return 'Masukkan tahun yang valid (1900–2100).';
    }
    return null;
  }

  String? _validateEndYear(String? value) {
    final yearError = _validateYear(value);
    if (yearError != null) return yearError;

    final start = int.tryParse(_startYear.trim());
    final end = int.tryParse(value!.trim());
    if (start != null && end != null && end < start) {
      return 'Tahun selesai harus sama atau setelah tahun mulai.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nama sekolah atau universitas',
                    labelText: 'Institusi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => _institution = value,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Institusi wajib diisi.'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Contoh: S1 Ilmu Komputer',
                    labelText: 'Jenjang / program studi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _degree = value,
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Jenjang atau program studi wajib diisi.'
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tahun mulai',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) => _startYear = value,
                        validator: _validateYear,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Tahun selesai',
                          hintText: 'Atau Sekarang',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) => _endYear = value,
                        validator: _validateEndYear,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  onChanged: (value) => _description = value,
                  decoration: InputDecoration(
                    labelText: 'Deskripsi (opsional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await showDialog<void>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          title: const Text('Education successfully added!'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Institution: ${_institution.trim()}'),
                                Text('Degree / program: ${_degree.trim()}'),
                                Text('Start year: ${_startYear.trim()}'),
                                Text('End year: ${_endYear.trim()}'),
                                Text(
                                  'Description: ${_description.trim().isEmpty ? '-' : _description.trim()}',
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
