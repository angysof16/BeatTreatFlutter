import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../data/data.dart';
import '../widgets/widgets.dart';

class EscribirResenaScreen extends StatefulWidget {
  final AlbumData? albumPreseleccionado;
  const EscribirResenaScreen({super.key, this.albumPreseleccionado});

  @override
  State<EscribirResenaScreen> createState() => _EscribirResenaScreenState();
}

class _EscribirResenaScreenState extends State<EscribirResenaScreen> {
  AlbumData? _albumSeleccionado;
  int _calificacion = 0;
  final _textoCtrl = TextEditingController();
  bool _expandirSelector = false;
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    _albumSeleccionado = widget.albumPreseleccionado;
  }

  @override
  void dispose() {
    _textoCtrl.dispose();
    super.dispose();
  }

  bool get _puedePublicar =>
      _albumSeleccionado != null &&
      _calificacion > 0 &&
      _textoCtrl.text.trim().isNotEmpty;

  void _publicar() {
    if (!_puedePublicar) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('¡Resena publicada!', style: GoogleFonts.spaceGrotesk()),
        backgroundColor: BeatTreatColors.purple60,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeatTreatColors.background,
      appBar: AppBar(
        backgroundColor: BeatTreatColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            // Logo imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'images/beattreat.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [BeatTreatColors.purple60, BeatTreatColors.purpleDark]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.music_note, color: Colors.white, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text('BeatTreat',
                style: GoogleFonts.outfit(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: _puedePublicar ? _publicar : null,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _puedePublicar ? Colors.white : Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text('Publicar',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _puedePublicar ? BeatTreatColors.purple60 : Colors.white38,
                  )),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text('Nueva resena',
                style: GoogleFonts.outfit(
                    fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            Text('Comparte tu opinión con la comunidad',
                style: GoogleFonts.spaceGrotesk(fontSize: 14, color: Colors.white38)),
            const SizedBox(height: 24),

            Text('Álbum',
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 8),
            _buildSelectorAlbum(),
            const SizedBox(height: 24),

            Text('Calificación',
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 8),
            _buildCalificacion(),
            const SizedBox(height: 24),

            Text('Tu opinión',
                style: GoogleFonts.spaceGrotesk(
                    fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(height: 8),
            _buildCampoTexto(),
            const SizedBox(height: 32),

            PurpleButton(
                label: 'Publicar resena', onTap: _publicar, enabled: _puedePublicar),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectorAlbum() {
    if (widget.albumPreseleccionado != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BeatTreatColors.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [BeatTreatColors.purple60, BeatTreatColors.purpleDark]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.album, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_albumSeleccionado!.nombre,
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Text('Álbum seleccionado',
                      style: GoogleFonts.spaceGrotesk(
                          fontSize: 12, color: Colors.white38)),
                ],
              ),
            ),
            const Icon(Icons.lock, color: BeatTreatColors.purple60, size: 18),
          ],
        ),
      );
    }

    final albumsFiltrados = _busqueda.isEmpty
        ? albumsQuemados
        : albumsQuemados
            .where((a) => '${a.nombre} — ${a.artista}'
                .toLowerCase()
                .contains(_busqueda.toLowerCase()))
            .toList();

    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _expandirSelector = !_expandirSelector),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BeatTreatColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [BeatTreatColors.purple60, BeatTreatColors.purpleDark]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.album, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _albumSeleccionado == null
                      ? Text('Seleccionar álbum',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 15, color: Colors.white38))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_albumSeleccionado!.nombre,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                            Text(_albumSeleccionado!.artista,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 12, color: Colors.white38)),
                          ],
                        ),
                ),
                Icon(
                    _expandirSelector
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white38),
              ],
            ),
          ),
        ),
        if (_expandirSelector)
          Container(
            decoration: const BoxDecoration(
              color: BeatTreatColors.surfaceVariant,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: TextField(
                    onChanged: (v) => setState(() => _busqueda = v),
                    style: GoogleFonts.spaceGrotesk(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.white38, fontSize: 14),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white38, size: 18),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(color: Colors.white12, height: 1),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: albumsFiltrados.length,
                    separatorBuilder: (_, __) =>
                        const Divider(color: Colors.white10, height: 1),
                    itemBuilder: (_, i) {
                      final album = albumsFiltrados[i];
                      return GestureDetector(
                        onTap: () => setState(() {
                          _albumSeleccionado = album;
                          _expandirSelector = false;
                          _busqueda = '';
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: BeatTreatColors.purple60,
                                      borderRadius: BorderRadius.circular(4))),
                              const SizedBox(width: 12),
                              Text('${album.nombre} — ${album.artista}',
                                  style: GoogleFonts.spaceGrotesk(
                                      color: Colors.white, fontSize: 14)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCalificacion() {
    final etiquetas = ['', 'Muy malo', 'Malo', 'Regular', 'Bueno', 'Excelente'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: BeatTreatColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < _calificacion;
              return GestureDetector(
                onTap: () => setState(() => _calificacion = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: filled ? BeatTreatColors.gold : Colors.white24,
                    size: 40,
                  ),
                ),
              );
            }),
          ),
          if (_calificacion > 0) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [BeatTreatColors.purple60, Color(0xFF8B5CF6)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(etiquetas[_calificacion],
                  style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCampoTexto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: BeatTreatColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: _textoCtrl,
            onChanged: (_) => setState(() {}),
            maxLines: 6,
            maxLength: 500,
            style: GoogleFonts.spaceGrotesk(color: Colors.white),
            decoration: InputDecoration(
              hintText:
                  '¿Qué te pareció este álbum? Cuéntale a la comunidad...',
              hintStyle:
                  GoogleFonts.spaceGrotesk(color: Colors.white24, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterStyle:
                  GoogleFonts.spaceGrotesk(color: Colors.white38, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
} 