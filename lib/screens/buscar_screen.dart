import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../data/data.dart';
import '../widgets/widgets.dart';
import 'album_detalle_screen.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({super.key});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;
  final _queryCtrl = TextEditingController();
  String _query = '';

  // Resultados álbumes
  List<AlbumData> get _resultadosAlbumes {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return albumsQuemados.where((a) =>
      a.nombre.toLowerCase().contains(q) || a.artista.toLowerCase().contains(q)).toList();
  }

  // Resultados usuarios
  List<UsuarioData> get _resultadosUsuarios {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return usuariosQuemados.where((u) =>
      u.nombre.toLowerCase().contains(q) || u.username.toLowerCase().contains(q)).toList();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() => _tabIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _queryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeatTreatColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: BeatTreatColors.surface,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _queryCtrl,
                        autofocus: true,
                        onChanged: (v) => setState(() => _query = v),
                        style: GoogleFonts.spaceGrotesk(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Buscar álbumes, artistas o usuarios...',
                          hintStyle: GoogleFonts.spaceGrotesk(color: Colors.white38, fontSize: 13),
                          prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
                          suffixIcon: _query.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                                  onPressed: () => setState(() { _queryCtrl.clear(); _query = ''; }),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          //  Tabs Álbumes / Usuarios 
          if (_query.isNotEmpty)
            Container(
              color: BeatTreatColors.surface,
              child: TabBar(
                controller: _tabController,
                indicatorColor: BeatTreatColors.purple60,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white38,
                labelStyle: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.bold, fontSize: 14),
                unselectedLabelStyle: GoogleFonts.spaceGrotesk(fontSize: 14),
                tabs: [
                  Tab(text: 'Álbumes (${_resultadosAlbumes.length})'),
                  Tab(text: 'Usuarios (${_resultadosUsuarios.length})'),   // ← funcionalidad adicional
                ],
              ),
            ),

          //  Contenido 
          Expanded(
            child: _query.isEmpty
                ? _buildEstadoVacio()
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildResultadosAlbumes(),
                      _buildResultadosUsuarios(),    // ← funcionalidad adicional
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEstadoVacio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, color: Colors.white.withOpacity(0.12), size: 80),
          const SizedBox(height: 16),
          Text('Busca tus álbumes,\nartistas o usuarios favoritos',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(fontSize: 15, color: Colors.white24)),
        ],
      ),
    );
  }

  Widget _buildResultadosAlbumes() {
    if (_resultadosAlbumes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: Colors.white.withOpacity(0.12), size: 64),
            const SizedBox(height: 12),
            Text('Sin resultados para "$_query"',
              style: GoogleFonts.spaceGrotesk(color: Colors.white30, fontSize: 15)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _resultadosAlbumes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) {
        final album = _resultadosAlbumes[i];
        return GestureDetector(
          onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => AlbumDetalleScreen(album: album))),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BeatTreatColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: BeatTreatColors.purpleDark,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.album, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(album.nombre,
                        style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                      Text(album.artista,
                        style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white38)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white24),
              ],
            ),
          ),
        );
      },
    );
  }

  //  FUNCIONALIDAD ADICIONAL: Búsqueda de usuarios 
  Widget _buildResultadosUsuarios() {
    if (_resultadosUsuarios.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search, color: Colors.white.withOpacity(0.12), size: 64),
            const SizedBox(height: 12),
            Text('No se encontraron usuarios\npara "$_query"',
              textAlign: TextAlign.center,
              style: GoogleFonts.spaceGrotesk(color: Colors.white30, fontSize: 15)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _resultadosUsuarios.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => _UsuarioCard(usuario: _resultadosUsuarios[i]),
    );
  }
}

class _UsuarioCard extends StatefulWidget {
  final UsuarioData usuario;
  const _UsuarioCard({required this.usuario});

  @override
  State<_UsuarioCard> createState() => _UsuarioCardState();
}

class _UsuarioCardState extends State<_UsuarioCard> {
  bool _siguiendo = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BeatTreatColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: BeatTreatColors.purple60.withOpacity(0.2),
                child: Text(
                  widget.usuario.nombre.substring(0, 1).toUpperCase(),
                  style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: BeatTreatColors.purple60),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.usuario.nombre,
                  style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(widget.usuario.username,
                  style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white38)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('${widget.usuario.seguidores}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white60, fontWeight: FontWeight.w600)),
                    Text(' seguidores', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white30)),
                    const SizedBox(width: 10),
                    Text('${widget.usuario.siguiendo}', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white60, fontWeight: FontWeight.w600)),
                    Text(' siguiendo', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white30)),
                  ],
                ),
              ],
            ),
          ),

          // Botón seguir/siguiendo
          GestureDetector(
            onTap: () => setState(() => _siguiendo = !_siguiendo),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _siguiendo ? Colors.transparent : BeatTreatColors.purple60,
                border: Border.all(
                  color: _siguiendo ? BeatTreatColors.purple60 : Colors.transparent,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _siguiendo ? 'Siguiendo' : 'Seguir',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 13, fontWeight: FontWeight.w600,
                  color: _siguiendo ? BeatTreatColors.purple60 : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
