import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/theme.dart';
import '../data/data.dart';
import '../widgets/widgets.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos quemados del perfil actual
    const perfil = (
      nombre: 'Alex Morrison',
      usuario: '@alexmrrsn',
      bio: 'Amante del rock clásico y el reggaetón. Reseno música desde 2020. 🎵',
      siguiendo: 127,
      seguidores: 89,
    );

    return Scaffold(
      backgroundColor: BeatTreatColors.background,
      body: CustomScrollView(
        slivers: [
          //  AppBar con banner 
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: BeatTreatColors.surface,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
              IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.white), onPressed: () {
                Navigator.popUntil(context, (r) => r.isFirst);
              }),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Banner de fondo
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF1A1230), BeatTreatColors.purple60],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Decoración
                  Positioned(right: 0, bottom: 0,
                    child: Icon(Icons.music_note, color: Colors.white.withOpacity(0.08), size: 160)),

                  // Avatar + nombre
                  Positioned(
                    left: 20, bottom: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: BeatTreatColors.surfaceVariant,
                              child: const Icon(Icons.account_circle, color: Colors.white60, size: 64),
                            ),
                            Positioned(
                              right: 0, bottom: 0,
                              child: Container(
                                width: 22, height: 22,
                                decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                child: const Icon(Icons.edit, color: Colors.white, size: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Botones de acción
                  Positioned(
                    right: 16, bottom: 20,
                    child: Row(
                      children: [
                        _SmallButton(label: 'Siguiendo', onTap: () {}),
                        const SizedBox(width: 8),
                        _SmallButton(label: 'Mensaje', onTap: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  Contenido 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info básica
                  Text(perfil.nombre, style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(perfil.usuario, style: GoogleFonts.spaceGrotesk(fontSize: 14, color: Colors.white54)),
                  const SizedBox(height: 8),
                  Text(perfil.bio, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white70, height: 1.4)),
                  const SizedBox(height: 12),

                  // Contadores
                  Row(
                    children: [
                      _StatChip(label: '${perfil.siguiendo} Siguiendo'),
                      const SizedBox(width: 16),
                      _StatChip(label: '${perfil.seguidores} Seguidores'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  //  Álbumes favoritos 
                  Text('Álbumes Favoritos', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 130,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: albumsQuemados.take(3).length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (_, i) {
                        final album = albumsQuemados[i];
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: album.imagenUrl,
                                width: 90, height: 90, fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => Container(
                                  width: 90, height: 90,
                                  color: BeatTreatColors.surfaceVariant,
                                  child: const Icon(Icons.album, color: Colors.white30, size: 30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 90,
                              child: Text(album.nombre,
                                style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white),
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  //  Resenas recientes 
                  Row(
                    children: [
                      Text('Resenas recientes', style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Spacer(),
                      Row(
                        children: [
                          Text('Ver todas', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white)),
                          const Icon(Icons.arrow_forward, color: Colors.white, size: 14),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...resenasQuemadas.take(2).map((r) => _ResenaCard(resena: r)),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SmallButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: BeatTreatColors.purple60,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  const _StatChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: GoogleFonts.spaceGrotesk(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500));
  }
}

class _ResenaCard extends StatelessWidget {
  final ResenaData resena;
  const _ResenaCard({required this.resena});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: BeatTreatColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 16, backgroundColor: BeatTreatColors.surfaceVariant,
                child: Icon(Icons.account_circle, color: Colors.white60, size: 28)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resena.autorNombre, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(resena.autorUsuario, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
                ],
              ),
              const Spacer(),
              Text(resena.fecha, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
            ],
          ),
          const SizedBox(height: 8),
          StarRating(rating: resena.calificacion, size: 14),
          const SizedBox(height: 6),
          Text(resena.texto, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white70, height: 1.4)),
        ],
      ),
    );
  }
}
