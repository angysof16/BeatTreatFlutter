import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';
import '../data/data.dart';
import 'album_detalle_screen.dart';
import 'perfil_screen.dart';
import 'buscar_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomIndex = 0;

  void _onBottomTap(int i) {
    if (i == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const BuscarScreen()));
    } else if (i == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilScreen()));
    } else {
      setState(() => _bottomIndex = i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeatTreatColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: _TopBarHome(
          onSearchTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BuscarScreen())),
          onProfileTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PerfilScreen())),
        ),
      ),
      body: _HomeBody(onAlbumTap: (album) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => AlbumDetalleScreen(album: album)));
      }),
      bottomNavigationBar: BeatTreatBottomNav(currentIndex: _bottomIndex, onTap: _onBottomTap),
    );
  }
}

//  Top Bar 
class _TopBarHome extends StatelessWidget {
  final VoidCallback onSearchTap;
  final VoidCallback onProfileTap;
  const _TopBarHome({required this.onSearchTap, required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BeatTreatColors.surface,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [BeatTreatColors.purple60, BeatTreatColors.purpleDark]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.music_note, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Text('BeatTreat', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: onSearchTap),
              GestureDetector(
                onTap: onProfileTap,
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: BeatTreatColors.surfaceVariant,
                  child: Icon(Icons.account_circle, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}

//  Home Body 
class _HomeBody extends StatelessWidget {
  final void Function(AlbumData) onAlbumTap;
  const _HomeBody({required this.onAlbumTap});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        //  Banner 
        _Banner(),
        const SizedBox(height: 24),

        //  Secciones por artista 
        ...artistasQuemados.map((artista) => _ArtistaSection(
          artista: artista,
          onAlbumTap: onAlbumTap,
        )),
      ],
    );
  }
}

//  Banner 
class _Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1230), BeatTreatColors.purple60],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Nota musical decorativa
          Positioned(right: 16, bottom: 10,
            child: Icon(Icons.music_note, color: Colors.white.withOpacity(0.1), size: 100)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tu mejor ritmo', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Text('todos los días', style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 8),
                Text('Descubre, resena y comparte música', style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white70)),
              ],
            ),
          ),
          // Dots indicadores
          Positioned(bottom: 12, right: 16,
            child: Row(children: List.generate(3, (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 6, height: 6,
              decoration: BoxDecoration(
                color: i == 0 ? Colors.white : Colors.white38,
                shape: BoxShape.circle,
              ),
            ))),
          ),
        ],
      ),
    );
  }
}

//  Sección de artista 
class _ArtistaSection extends StatelessWidget {
  final ArtistaData artista;
  final void Function(AlbumData) onAlbumTap;
  const _ArtistaSection({required this.artista, required this.onAlbumTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(artista.nombre, style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
              const Spacer(),
              const Icon(Icons.arrow_forward, color: Colors.white54, size: 18),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 145,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: artista.albumes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, i) => _AlbumItem(album: artista.albumes[i], onTap: () => onAlbumTap(artista.albumes[i])),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

//  Item álbum 
class _AlbumItem extends StatelessWidget {
  final AlbumData album;
  final VoidCallback onTap;
  const _AlbumItem({required this.album, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: album.imagenUrl,
                width: 100, height: 100, fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 100, height: 100,
                  color: BeatTreatColors.surfaceVariant,
                  child: const Icon(Icons.music_note, color: Colors.white30, size: 32),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 100, height: 100,
                  color: BeatTreatColors.surfaceVariant,
                  child: const Icon(Icons.music_note, color: Colors.white30, size: 32),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(album.nombre,
              style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 12),
              maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
