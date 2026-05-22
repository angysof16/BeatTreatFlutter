import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/theme.dart';

// 
// ImagenAlbum — detecta automáticamente si usar asset o network.
//
// USO:
//   ImagenAlbum(url: album.imagenUrl, width: 100, height: 100)
//
// REGLA:
//   - Si imagenUrl empieza con 'assets/'  → AssetImage  (archivo local)
//   - Si empieza con 'http'               → CachedNetworkImage
//
// Para cambiar un álbum a asset basta con poner en data.dart:
//   imagenUrl: 'assets/images/queen_night_opera.jpg'
// 
class ImagenAlbum extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const ImagenAlbum({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  Widget _placeholder() => Container(
    width: width, height: height,
    decoration: BoxDecoration(
      color: BeatTreatColors.surfaceVariant,
      borderRadius: borderRadius,
    ),
    child: const Icon(Icons.music_note, color: Colors.white24, size: 32),
  );

  @override
  Widget build(BuildContext context) {
    Widget img;

    if (url.startsWith('assets/')) {
      //  Asset local 
      img = Image.asset(
        url,
        width: width, height: height, fit: fit,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else if (url.startsWith('http')) {
      //  URL de red 
      img = CachedNetworkImage(
        imageUrl: url,
        width: width, height: height, fit: fit,
        placeholder: (_, __) => _placeholder(),
        errorWidget: (_, __, ___) => _placeholder(),
      );
    } else {
      img = _placeholder();
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: img);
    }
    return img;
  }
}

//  Top Bar BeatTreat 
class BeatTreatTopBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  const BeatTreatTopBar({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BeatTreatColors.surface,
      title: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: BeatTreatColors.purple60,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.music_note, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Text(
            'BeatTreat',
            style: GoogleFonts.outfit(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white,
            ),
          ),
        ],
      ),
      actions: actions,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//  Star Rating Row 
class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  const StarRating({super.key, required this.rating, this.size = 16});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        if (i < rating.floor()) {
          return Icon(Icons.star, color: BeatTreatColors.gold, size: size);
        } else if (i == rating.floor() && rating % 1 >= 0.5) {
          return Icon(Icons.star_half, color: BeatTreatColors.gold, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.grey, size: size);
        }
      }),
    );
  }
}

//  Purple Gradient Button 
class PurpleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool enabled;
  const PurpleButton({super.key, required this.label, this.onTap, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: enabled
              ? const LinearGradient(colors: [BeatTreatColors.purple60, Color(0xFF8B5CF6)])
              : null,
          color: enabled ? null : BeatTreatColors.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16, fontWeight: FontWeight.bold,
            color: enabled ? Colors.white : Colors.white38,
          ),
        ),
      ),
    );
  }
}

//  Campo de texto oscuro 
class DarkTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const DarkTextField({
    super.key,
    required this.hint,
    this.icon,
    this.obscure = false,
    this.controller,
    this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BeatTreatColors.surfaceVariant,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        onChanged: onChanged,
        maxLines: maxLines,
        style: GoogleFonts.spaceGrotesk(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.spaceGrotesk(color: Colors.white38),
          prefixIcon: icon != null ? Icon(icon, color: Colors.white38, size: 20) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

//  Chip de info (ano, género, etc.) 
class InfoChip extends StatelessWidget {
  final String text;
  const InfoChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: BeatTreatColors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 12),
      ),
    );
  }
}

//  Bottom Navigation Bar 
class BeatTreatBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const BeatTreatBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_filled, 'Inicio'),
      (Icons.bookmark, 'Biblioteca'),
      (Icons.explore, 'Descubre'),
      (Icons.chat_bubble, 'Chat'),
      (Icons.people, 'Siguiendo'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: BeatTreatColors.bottomBar,
        border: Border(top: BorderSide(color: Colors.white12)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (i) {
              final selected = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Icon(
                    items[i].$1,
                    color: selected ? BeatTreatColors.purple60 : Colors.white,
                    size: 26,
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
