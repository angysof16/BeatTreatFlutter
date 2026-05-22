import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../theme/theme.dart';
import '../data/data.dart';
import '../widgets/widgets.dart';
import 'escribir_resena_screen.dart';

class AlbumDetalleScreen extends StatefulWidget {
  final AlbumData album;
  const AlbumDetalleScreen({super.key, required this.album});

  @override
  State<AlbumDetalleScreen> createState() => _AlbumDetalleScreenState();
}

class _AlbumDetalleScreenState extends State<AlbumDetalleScreen> {
  bool _esFavorito = false;

  //  Audio 
  final AudioPlayer _player = AudioPlayer();
  int? _cancionActualIndex;       // índice de la canción cargada
  bool _cargando = false;         // spinner mientras carga la URL
  bool _reproduciendo = false;    // play/pause estado UI
  Duration _posicion = Duration.zero;
  Duration _duracion = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Escuchar cambios de posición
    _player.positionStream.listen((pos) {
      if (mounted) setState(() => _posicion = pos);
    });

    // Escuchar duración total
    _player.durationStream.listen((dur) {
      if (mounted) setState(() => _duracion = dur ?? Duration.zero);
    });

    // Escuchar estado play/pause/completed
    _player.playerStateStream.listen((state) {
      if (!mounted) return;
      final playing = state.playing;
      final completed = state.processingState == ProcessingState.completed;
      setState(() {
        _reproduciendo = playing && !completed;
        if (completed) {
          _posicion = Duration.zero;
          _reproduciendo = false;
        }
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  //  Toca una canción (o pausa si ya estaba sonando) 
  Future<void> _toggleCancion(int index) async {
    final cancion = widget.album.canciones[index];

    // Sin URL disponible → toast informativo
    if (cancion.audioUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Preview no disponible para esta canción',
            style: GoogleFonts.spaceGrotesk()),
          backgroundColor: BeatTreatColors.surfaceVariant,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    // Pausa si es la misma canción y ya estaba sonando
    if (_cancionActualIndex == index) {
      if (_reproduciendo) {
        await _player.pause();
      } else {
        await _player.play();
      }
      return;
    }

    // Nueva canción → cargar y reproducir
    setState(() { _cargando = true; _cancionActualIndex = index; _posicion = Duration.zero; });

    try {
      await _player.setAudioSource(AudioSource.asset(cancion.audioUrl!));
      await _player.play();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar el audio. Verifica que el archivo esté en assets/audio/',
              style: GoogleFonts.spaceGrotesk()),
            backgroundColor: BeatTreatColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() { _cancionActualIndex = null; });
      }
    } finally {
      if (mounted) setState(() => _cargando = false);
    }
  }

  String _formatDur(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final album = widget.album;

    return Scaffold(
      backgroundColor: BeatTreatColors.background,

      //  Mini-player flotante (aparece cuando hay canción activa) 
      bottomNavigationBar: _cancionActualIndex != null
          ? _MiniPlayer(
              cancion: widget.album.canciones[_cancionActualIndex!],
              album: album,
              reproduciendo: _reproduciendo,
              cargando: _cargando,
              posicion: _posicion,
              duracion: _duracion,
              onPlayPause: () => _toggleCancion(_cancionActualIndex!),
              onClose: () async {
                await _player.stop();
                setState(() { _cancionActualIndex = null; _posicion = Duration.zero; });
              },
              onSeek: (v) => _player.seek(Duration(seconds: (v * _duracion.inSeconds).round())),
            )
          : null,

      body: CustomScrollView(
        slivers: [
          //  Portada con gradiente 
          SliverAppBar(
            expandedHeight: 340,
            pinned: true,
            backgroundColor: BeatTreatColors.background,
            leading: Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: GestureDetector(
                  onTap: () => setState(() => _esFavorito = !_esFavorito),
                  child: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _esFavorito ? Icons.favorite : Icons.favorite_border,
                      color: _esFavorito ? Colors.red : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  ImagenAlbum(url: album.imagenUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter, end: Alignment.bottomCenter,
                        colors: [
                          BeatTreatColors.purple60.withOpacity(0.3),
                          BeatTreatColors.background,
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: ImagenAlbum(
                      url: album.imagenUrl,
                      width: 170, height: 170,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(album.nombre, style: GoogleFonts.outfit(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1)),
                  const SizedBox(height: 4),
                  Text(album.artista, style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w600, color: BeatTreatColors.purple60)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 6, children: [InfoChip(text: album.ano), InfoChip(text: album.genero)]),
                  const SizedBox(height: 16),
                  Text(album.descripcion, style: GoogleFonts.spaceGrotesk(fontSize: 14, color: Colors.white70, height: 1.5)),
                  const SizedBox(height: 16),
                  _CalificacionCard(album: album),
                  const SizedBox(height: 16),
                  _BotonVerResenas(album: album),
                  const SizedBox(height: 12),

                  //  Botón escribir resena 
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (_) => EscribirResenaScreen(albumPreseleccionado: album),
                    )),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: BeatTreatColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit, color: BeatTreatColors.purple60, size: 20),
                          const SizedBox(width: 10),
                          Text('Escribir resena', style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  //  Canciones 
                  Row(
                    children: [
                      Text('Canciones', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Spacer(),
                      // Leyenda
                      Row(children: [
                        const Icon(Icons.play_circle_outline, color: BeatTreatColors.purple60, size: 14),
                        const SizedBox(width: 4),
                        Text('Toca para reproducir', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 8),

                  ...album.canciones.asMap().entries.map((e) => _CancionItem(
                    cancion: e.value,
                    index: e.key,
                    esUltima: e.key == album.canciones.length - 1,
                    esActiva: _cancionActualIndex == e.key,
                    reproduciendo: _reproduciendo && _cancionActualIndex == e.key,
                    cargandoEsta: _cargando && _cancionActualIndex == e.key,
                    onTap: () => _toggleCancion(e.key),
                  )),

                  const SizedBox(height: 24),
                  Text('Resenas', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  ...resenasQuemadas.map((r) => _ResenaItem(resena: r)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Mini-player flotante 
class _MiniPlayer extends StatelessWidget {
  final CancionData cancion;
  final AlbumData album;
  final bool reproduciendo;
  final bool cargando;
  final Duration posicion;
  final Duration duracion;
  final VoidCallback onPlayPause;
  final VoidCallback onClose;
  final ValueChanged<double> onSeek;

  const _MiniPlayer({
    required this.cancion,
    required this.album,
    required this.reproduciendo,
    required this.cargando,
    required this.posicion,
    required this.duracion,
    required this.onPlayPause,
    required this.onClose,
    required this.onSeek,
  });

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final progress = duracion.inSeconds > 0
        ? (posicion.inSeconds / duracion.inSeconds).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      decoration: const BoxDecoration(
        color: BeatTreatColors.surface,
        border: Border(top: BorderSide(color: BeatTreatColors.purple60, width: 1.5)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Portada mini
                ImagenAlbum(
                  url: album.imagenUrl,
                  width: 42, height: 42,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(width: 12),

                // Título + artista
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cancion.titulo,
                        style: GoogleFonts.spaceGrotesk(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(album.artista,
                        style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white38)),
                    ],
                  ),
                ),

                // Play/Pause o spinner
                if (cargando)
                  const SizedBox(width: 38, height: 38,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(color: BeatTreatColors.purple60, strokeWidth: 2),
                    ))
                else
                  IconButton(
                    icon: Icon(
                      reproduciendo ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      color: BeatTreatColors.purple60, size: 38,
                    ),
                    onPressed: onPlayPause,
                  ),

                // Cerrar
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white38, size: 20),
                  onPressed: onClose,
                ),
              ],
            ),

            //  Barra de progreso 
            Row(
              children: [
                Text(_fmt(posicion), style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white38)),
                Expanded(
                  child: Slider(
                    value: progress,
                    onChanged: onSeek,
                    activeColor: BeatTreatColors.purple60,
                    inactiveColor: Colors.white12,
                    thumbColor: BeatTreatColors.purple60,
                  ),
                ),
                Text(_fmt(duracion), style: GoogleFonts.spaceGrotesk(fontSize: 10, color: Colors.white38)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//  Fila de canción con botón de play 
class _CancionItem extends StatelessWidget {
  final CancionData cancion;
  final int index;
  final bool esUltima;
  final bool esActiva;
  final bool reproduciendo;
  final bool cargandoEsta;
  final VoidCallback onTap;

  const _CancionItem({
    required this.cancion,
    required this.index,
    required this.esUltima,
    required this.esActiva,
    required this.reproduciendo,
    required this.cargandoEsta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tieneAudio = cancion.audioUrl != null;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
            child: Row(
              children: [
                // Número / ícono de estado
                SizedBox(
                  width: 36, height: 36,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: esActiva
                            ? BeatTreatColors.purple60
                            : BeatTreatColors.surfaceVariant,
                        child: cargandoEsta
                            ? const SizedBox(width: 14, height: 14,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : esActiva
                                ? Icon(
                                    reproduciendo ? Icons.pause : Icons.play_arrow,
                                    color: Colors.white, size: 16)
                                : Text(cancion.numero.toString(),
                                    style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 12)),
                      ),
                      // Indicador de "sin preview" — bolita gris en esquina
                      if (!tieneAudio)
                        Positioned(
                          right: 0, bottom: 0,
                          child: Container(
                            width: 10, height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white24, shape: BoxShape.circle),
                            child: const Icon(Icons.music_off, size: 6, color: Colors.white54),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),

                // Título
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cancion.titulo,
                        style: GoogleFonts.spaceGrotesk(
                          color: esActiva ? BeatTreatColors.purple60 : Colors.white,
                          fontSize: 15,
                          fontWeight: esActiva ? FontWeight.w600 : FontWeight.normal,
                        )),
                      if (!tieneAudio)
                        Text('Sin preview', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white24)),
                    ],
                  ),
                ),

                // Duración
                Text(cancion.duracion, style: GoogleFonts.spaceGrotesk(color: Colors.white38, fontSize: 13)),
                const SizedBox(width: 4),

                // Ícono play visual (solo si tiene audio)
                if (tieneAudio)
                  Icon(Icons.play_circle_outline, color: Colors.white24, size: 18)
                else
                  const SizedBox(width: 18),
              ],
            ),
          ),
        ),
        if (!esUltima) const Divider(color: Colors.white10, height: 1),
      ],
    );
  }
}

//  Card de calificación 
class _CalificacionCard extends StatelessWidget {
  final AlbumData album;
  const _CalificacionCard({required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: BeatTreatColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(album.calificacionPromedio.toString(),
                style: GoogleFonts.outfit(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
              Text('${album.totalResenas} resenas',
                style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white38)),
            ],
          ),
          const Spacer(),
          StarRating(rating: album.calificacionPromedio, size: 28),
        ],
      ),
    );
  }
}

//  Botón ver resenas 
class _BotonVerResenas extends StatelessWidget {
  final AlbumData album;
  const _BotonVerResenas({required this.album});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [BeatTreatColors.purple60, Color(0xFF8B5CF6)]),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ver todas las resenas', style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('${album.totalResenas} opiniones', style: GoogleFonts.spaceGrotesk(fontSize: 12, color: Colors.white70)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(Icons.star, color: BeatTreatColors.gold, size: 16),
                const SizedBox(width: 4),
                Text(album.calificacionPromedio.toString(),
                  style: GoogleFonts.spaceGrotesk(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//  Item de resena 
class _ResenaItem extends StatelessWidget {
  final ResenaData resena;
  const _ResenaItem({required this.resena});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: BeatTreatColors.surfaceVariant, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 16, backgroundColor: BeatTreatColors.surface,
                child: Icon(Icons.account_circle, color: Colors.white60, size: 28)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(resena.autorNombre, style: GoogleFonts.spaceGrotesk(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(resena.autorUsuario, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
                ],
              ),
              const Spacer(),
              Text(resena.fecha, style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
            ],
          ),
          const SizedBox(height: 10),
          StarRating(rating: resena.calificacion),
          const SizedBox(height: 8),
          Text(resena.texto, style: GoogleFonts.spaceGrotesk(fontSize: 13, color: Colors.white70, height: 1.4)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Icon(Icons.chat_bubble_outline, color: Colors.white38, size: 14),
              const SizedBox(width: 4),
              Text('Ver comentarios', style: GoogleFonts.spaceGrotesk(fontSize: 11, color: Colors.white38)),
            ],
          ),
        ],
      ),
    );
  }
}
