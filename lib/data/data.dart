// DATOS QUEMADOS modelo

class AlbumData {
  final int id;
  final String nombre;
  final String artista;
  final String ano;
  final String genero;
  final String descripcion;
  final String imagenUrl; // 'assets/images/nombre.jpg'
  final double calificacionPromedio;
  final int totalResenas;
  final List<CancionData> canciones;

  const AlbumData({
    required this.id,
    required this.nombre,
    required this.artista,
    required this.ano,
    required this.genero,
    required this.descripcion,
    required this.imagenUrl,
    required this.calificacionPromedio,
    required this.totalResenas,
    required this.canciones,
  });
}

class CancionData {
  final int numero;
  final String titulo;
  final String duracion;
  // null = sin preview
  final String? audioUrl;

  const CancionData(this.numero, this.titulo, this.duracion, [this.audioUrl]);
}

class ResenaData {
  final String autorNombre;
  final String autorUsuario;
  final String texto;
  final double calificacion;
  final String fecha;
  const ResenaData({
    required this.autorNombre,
    required this.autorUsuario,
    required this.texto,
    required this.calificacion,
    required this.fecha,
  });
}

class ArtistaData {
  final int id;
  final String nombre;
  final List<AlbumData> albumes;
  const ArtistaData(
      {required this.id, required this.nombre, required this.albumes});
}

class UsuarioData {
  final String id;
  final String nombre;
  final String username;
  final String fotoUrl;
  final int seguidores;
  final int siguiendo;
  const UsuarioData({
    required this.id,
    required this.nombre,
    required this.username,
    required this.fotoUrl,
    required this.seguidores,
    required this.siguiendo,
  });
}

// ════════════════════════════════════════════════════════════════
// ASSETS DE AUDIO
// ════════════════════════════════════════════════════════════════

const _a1 = 'assets/audio/track_01.mp3'; // track de rock placeholder #1
const _a2 = 'assets/audio/track_02.mp3'; // track de rock placeholder #2
const _a3 = 'assets/audio/track_03.mp3'; // track de rock placeholder #3
const _a4 = 'assets/audio/track_04.mp3'; // track de rock placeholder #4
const _a5 = 'assets/audio/track_05.mp3'; // track de rock placeholder #5
const _a6 = 'assets/audio/track_06.mp3'; // track de rock placeholder #6

const them_bones = 'assets/audio/dirt_aic/them_bones.mp3';
const dam_that_river = 'assets/audio/dirt_aic/dam_that_river.mp3';
const rain_when_i_die = 'assets/audio/dirt_aic/rain_when_i_die.mp3';
const down_in_a_hole = 'assets/audio/dirt_aic/down_in_a_hole.mp3';
const sickman = 'assets/audio/dirt_aic/sickman.mp3';
const rooster = 'assets/audio/dirt_aic/rooster.mp3';
const junkhead = 'assets/audio/dirt_aic/junkhead.mp3';
const dirt = 'assets/audio/dirt_aic/dirt.mp3';
const god_smack = 'assets/audio/dirt_aic/god_smack.mp3';
const untitled = 'assets/audio/dirt_aic/untitled.mp3';
const hate_to_feel = 'assets/audio/dirt_aic/hate_to_feel.mp3';
const angry_chair = 'assets/audio/dirt_aic/angry_chair.mp3';
const would = 'assets/audio/dirt_aic/would.mp3';

// ════════════════════════════════════════════════════════════════
// ASSETS DE IMÁGENES
// ════════════════════════════════════════════════════════════════
const _imgs = 'assets/images/';

// ════════════════════════════════════════════════════════════════
// ABUMES
// ════════════════════════════════════════════════════════════════
final List<AlbumData> albumsQuemados = [
  //  ALICE IN CHAINS
  const AlbumData(
    id: 1,
    nombre: 'Dirt',
    artista: 'Alice in Chains',
    ano: '1992',
    genero: 'Grunge / Heavy Metal',
    descripcion:
        'Una de las cumbres del grunge y el metal alternativo. Dirt explora la adicción, el dolor y la oscuridad con una brutalidad musical pocas veces igualada.',
    imagenUrl: '${_imgs}aic_dirt.jpg',
    calificacionPromedio: 5.0,
    totalResenas: 7100,
    canciones: [
      CancionData(1, 'Them Bones', '2:27', them_bones),
      CancionData(2, 'Dam That River', '3:13', dam_that_river),
      CancionData(3, 'Rain When I Die', '5:24', rain_when_i_die),
      CancionData(4, 'Down in a Hole', '5:37', down_in_a_hole),
      CancionData(5, 'Sickman', '5:29', sickman),
      CancionData(6, 'Rooster', '6:14', rooster),
      CancionData(7, 'Junkhead', '5:09', junkhead),
      CancionData(8, 'Dirt', '5:20', dirt),
      CancionData(9, 'God Smack', '3:44', god_smack),
      CancionData(10, 'Would?', '3:29', would),
    ],
  ),

  const AlbumData(
    id: 2,
    nombre: 'Facelift',
    artista: 'Alice in Chains',
    ano: '1990',
    genero: 'Grunge / Heavy Metal',
    descripcion:
        'El álbum debut que presentó al mundo el sonido único de Alice in Chains: guitarras pesadas, armonías vocales oscuras y letras perturbadoras.',
    imagenUrl: '${_imgs}aic_facelift.jpg',
    calificacionPromedio: 4.7,
    totalResenas: 4900,
    canciones: [
      CancionData(1, 'We Die Young', '2:42', _a1),
      CancionData(2, 'Man in the Box', '4:46', _a2),
      CancionData(3, 'Sea of Sorrow', '5:51', _a3),
      CancionData(4, 'Bleed the Freak', '4:31', _a4),
      CancionData(5, "I Can't Remember", '3:38', _a5),
      CancionData(6, 'Love, Hate, Love', '7:27', _a6),
      CancionData(7, "It Ain't Like That", '4:10'),
      CancionData(8, 'Sunshine', '4:11'),
    ],
  ),

  const AlbumData(
    id: 3,
    nombre: 'Jar of Flies',
    artista: 'Alice in Chains',
    ano: '1994',
    genero: 'Grunge / Acoustic Rock',
    descripcion:
        'EP acústico que demostró otra faceta de la banda. Melancolía y belleza acústica que contrasta con su sonido eléctrico habitual.',
    imagenUrl: '${_imgs}aic_jar_of_flies.jpg',
    calificacionPromedio: 4.9,
    totalResenas: 5500,
    canciones: [
      CancionData(1, 'Rotten Apple', '6:57', _a1),
      CancionData(2, 'Nutshell', '4:20', _a2),
      CancionData(3, 'I Stay Away', '4:09', _a3),
      CancionData(4, 'No Excuses', '4:14', _a4),
      CancionData(5, 'Whale & Wasp', '2:55', _a5),
      CancionData(6, 'Don\u2019t Follow', '4:00', _a6),
      CancionData(7, 'Swing on This', '3:29'),
    ],
  ),
  //  QUEEN 
  const AlbumData(
    id: 4,
    nombre: 'A Night at the Opera',
    artista: 'Queen',
    ano: '1975',
    genero: 'Classic Rock',
    descripcion:
        'Considerado uno de los mejores álbumes de la historia del rock. Contiene Bohemian Rhapsody, una de las canciones más elaboradas jamás grabadas.',
    imagenUrl: '${_imgs}queen_night_opera.png',
    calificacionPromedio: 5.0,
    totalResenas: 8700,
    canciones: [
      CancionData(1, 'Death on Two Legs', '3:43', _a1),
      CancionData(2, 'Lazing on a Sunday Afternoon', '1:08', _a2),
      CancionData(3, "I'm in Love with My Car", '3:05', _a3),
      CancionData(4, "You're My Best Friend", '2:52', _a4),
      CancionData(5, 'Bohemian Rhapsody', '5:55', _a5),
      CancionData(6, 'Love of My Life', '3:38', _a6),
      CancionData(7, 'Good Company', '3:25'),
      CancionData(8, "'39", '3:29'),
      CancionData(9, 'God Save the Queen', '1:11'),
    ],
  ),

  const AlbumData(
    id: 5,
    nombre: 'News of the World',
    artista: 'Queen',
    ano: '1977',
    genero: 'Hard Rock / Arena Rock',
    descripcion:
        'Hogar de los himnos deportivos más icónicos del planeta. We Will Rock You y We Are the Champions son inseparables de la cultura popular.',
    imagenUrl: '${_imgs}queen_news_world.png',
    calificacionPromedio: 4.9,
    totalResenas: 6300,
    canciones: [
      CancionData(1, 'We Will Rock You', '2:01', _a1),
      CancionData(2, 'We Are the Champions', '2:59', _a2),
      CancionData(3, 'Sheer Heart Attack', '3:26', _a3),
      CancionData(4, 'All Dead, All Dead', '3:09', _a4),
      CancionData(5, 'Spread Your Wings', '4:34', _a5),
      CancionData(6, "It's Late", '6:26', _a6),
      CancionData(7, 'My Melancholy Blues', '3:27'),
    ],
  ),

  const AlbumData(
    id: 6,
    nombre: 'Innuendo',
    artista: 'Queen',
    ano: '1991',
    genero: 'Classic Rock / Art Rock',
    descripcion:
        'El último álbum de estudio grabado con Freddie Mercury. Una obra testamento de musicalidad y emoción sin igual, grabada mientras Mercury luchaba contra la enfermedad.',
    imagenUrl: '${_imgs}queen_innuendo.png',
    calificacionPromedio: 4.8,
    totalResenas: 4200,
    canciones: [
      CancionData(1, 'Innuendo', '6:31', _a1),
      CancionData(2, "I'm Going Slightly Mad", '4:22', _a2),
      CancionData(3, 'Headlong', '4:38', _a3),
      CancionData(4, 'I Cant Live with You', '4:32', _a4),
      CancionData(5, 'Ride the Wild Wind', '4:42', _a5),
      CancionData(6, 'All Gods People', '4:20', _a6),
      CancionData(7, 'These Are the Days of Our Lives', '4:15'),
      CancionData(8, 'The Show Must Go On', '4:33'),
    ],
  ),

  //  PINK FLOYD
  const AlbumData(
    id: 7,
    nombre: 'The Dark Side of the Moon',
    artista: 'Pink Floyd',
    ano: '1973',
    genero: 'Progressive Rock / Psychedelic',
    descripcion:
        'Uno de los álbumes más vendidos de la historia. Una obra conceptual sobre la condición humana: el tiempo, la codicia, la locura y la muerte.',
    imagenUrl: '${_imgs}pf_dark_side.png',
    calificacionPromedio: 5.0,
    totalResenas: 12400,
    canciones: [
      CancionData(1, 'Speak to Me', '1:30', _a1),
      CancionData(2, 'Breathe', '2:43', _a2),
      CancionData(3, 'On the Run', '3:30', _a3),
      CancionData(4, 'Time', '7:06', _a4),
      CancionData(5, 'The Great Gig in the Sky', '4:47', _a5),
      CancionData(6, 'Money', '6:22', _a6),
      CancionData(7, 'Us and Them', '7:50'),
      CancionData(8, 'Any Colour You Like', '3:26'),
      CancionData(9, 'Brain Damage', '3:50'),
      CancionData(10, 'Eclipse', '2:03'),
    ],
  ),

  const AlbumData(
    id: 8,
    nombre: 'The Wall',
    artista: 'Pink Floyd',
    ano: '1979',
    genero: 'Progressive Rock / Art Rock',
    descripcion:
        'Ópera rock doble sobre el aislamiento, el trauma de la guerra y la construcción de muros mentales. Another Brick in the Wall es uno de los himnos más reconocidos.',
    imagenUrl: '${_imgs}pf_the_wall.jpg',
    calificacionPromedio: 4.9,
    totalResenas: 9800,
    canciones: [
      CancionData(1, 'In the Flesh?', '3:16', _a1),
      CancionData(2, 'The Thin Ice', '2:27', _a2),
      CancionData(3, 'Another Brick in the Wall Pt.1', '3:11', _a3),
      CancionData(4, 'The Happiest Days of Our Lives', '1:46', _a4),
      CancionData(5, 'Another Brick in the Wall Pt.2', '3:59', _a5),
      CancionData(6, 'Mother', '5:32', _a6),
      CancionData(7, 'Goodbye Blue Sky', '2:45'),
      CancionData(8, 'Young Lust', '3:25'),
      CancionData(9, 'Comfortably Numb', '6:22'),
      CancionData(10, 'Run Like Hell', '4:20'),
    ],
  ),

  const AlbumData(
    id: 9,
    nombre: 'Wish You Were Here',
    artista: 'Pink Floyd',
    ano: '1975',
    genero: 'Progressive Rock',
    descripcion:
        'Un homenaje a Syd Barrett y una reflexión sobre la ausencia y la desconexión en la industria musical. Shine On You Crazy Diamond es una de las piezas más emotivas del rock.',
    imagenUrl: '${_imgs}pf_wish_you_were_here.png',
    calificacionPromedio: 4.9,
    totalResenas: 8100,
    canciones: [
      CancionData(1, 'Shine On You Crazy Diamond Pts. 1-5', '13:30', _a1),
      CancionData(2, 'Welcome to the Machine', '7:30', _a2),
      CancionData(3, 'Have a Cigar', '5:08', _a3),
      CancionData(4, 'Wish You Were Here', '5:34', _a4),
      CancionData(5, 'Shine On You Crazy Diamond Pts. 6-9', '12:30', _a5),
    ],
  ),

  //  BLACK SABBATH (3 álbumes) 
  const AlbumData(
    id: 10,
    nombre: 'Paranoid',
    artista: 'Black Sabbath',
    ano: '1970',
    genero: 'Heavy Metal / Doom Metal',
    descripcion:
        'El álbum que inventó el heavy metal tal como lo conocemos. Iron Man, Paranoid y War Pigs son pilares fundamentales de la música pesada del siglo XX.',
    imagenUrl: '${_imgs}sabbath_paranoid.jpg',
    calificacionPromedio: 5.0,
    totalResenas: 9400,
    canciones: [
      CancionData(1, 'War Pigs', '7:54', _a1),
      CancionData(2, 'Paranoid', '2:48', _a2),
      CancionData(3, 'Planet Caravan', '4:31', _a3),
      CancionData(4, 'Iron Man', '5:56', _a4),
      CancionData(5, 'Electric Funeral', '4:51', _a5),
      CancionData(6, 'Hand of Doom', '7:09', _a6),
      CancionData(7, 'Rat Salad', '2:30'),
      CancionData(8, 'Jack the Stripper / Fairies Wear Boots', '6:14'),
    ],
  ),

  const AlbumData(
    id: 11,
    nombre: 'Black Sabbath',
    artista: 'Black Sabbath',
    ano: '1970',
    genero: 'Heavy Metal / Doom Metal',
    descripcion:
        'El álbum debut que nació el mismo día que el metal. Con el riff de apertura de Black Sabbath, la banda creó un nuevo género musical de la nada.',
    imagenUrl: '${_imgs}sabbath_debut.jpg',
    calificacionPromedio: 4.8,
    totalResenas: 6700,
    canciones: [
      CancionData(1, 'Black Sabbath', '6:16', _a1),
      CancionData(2, 'The Wizard', '4:22', _a2),
      CancionData(3, 'Behind the Wall of Sleep', '3:25', _a3),
      CancionData(4, 'N.I.B.', '6:08', _a4),
      CancionData(5, 'Evil Woman', '3:24', _a5),
      CancionData(6, 'Sleeping Village', '7:13', _a6),
      CancionData(7, 'Warning', '10:35'),
    ],
  ),

  const AlbumData(
    id: 12,
    nombre: 'Heaven and Hell',
    artista: 'Black Sabbath',
    ano: '1980',
    genero: 'Heavy Metal',
    descripcion:
        'El primer álbum con Ronnie James Dio como vocalista. Una reinvención brillante que demostró que Black Sabbath podía evolucionar y seguir siendo relevantes.',
    imagenUrl: '${_imgs}sabbath_heaven_hell.jpg',
    calificacionPromedio: 4.7,
    totalResenas: 4100,
    canciones: [
      CancionData(1, 'Neon Knights', '3:49', _a1),
      CancionData(2, 'Children of the Sea', '5:35', _a2),
      CancionData(3, 'Lady Evil', '4:32', _a3),
      CancionData(4, 'Heaven and Hell', '6:59', _a4),
      CancionData(5, 'Wishing Well', '4:02', _a5),
      CancionData(6, 'Die Young', '4:47', _a6),
      CancionData(7, 'Walk Away', '4:06'),
      CancionData(8, 'Lonely Is the Word', '6:10'),
    ],
  ),

  //  METALLICA (3 álbumes) 
  const AlbumData(
    id: 13,
    nombre: 'Master of Puppets',
    artista: 'Metallica',
    ano: '1986',
    genero: 'Thrash Metal / Heavy Metal',
    descripcion:
        'Considerado el mejor álbum de thrash metal de todos los tiempos. Una obra maestra de complejidad técnica y potencia bruta que definió el metal moderno.',
    imagenUrl: '${_imgs}metallica_master.jpg',
    calificacionPromedio: 5.0,
    totalResenas: 11200,
    canciones: [
      CancionData(1, 'Battery', '5:12', _a1),
      CancionData(2, 'Master of Puppets', '8:35', _a2),
      CancionData(3, 'The Thing That Should Not Be', '6:36', _a3),
      CancionData(4, 'Welcome Home (Sanitarium)', '6:27', _a4),
      CancionData(5, 'Disposable Heroes', '8:17', _a5),
      CancionData(6, 'Leper Messiah', '5:40', _a6),
      CancionData(7, 'Orion', '8:27'),
      CancionData(8, 'Damage, Inc.', '5:32'),
    ],
  ),

  const AlbumData(
    id: 14,
    nombre: 'Ride the Lightning',
    artista: 'Metallica',
    ano: '1984',
    genero: 'Thrash Metal',
    descripcion:
        'El segundo álbum de Metallica es donde la banda comenzó a expandir sus horizontes musicales, mezclando velocidad brutal con composiciones más elaboradas.',
    imagenUrl: '${_imgs}metallica_ride.png',
    calificacionPromedio: 4.9,
    totalResenas: 7800,
    canciones: [
      CancionData(1, 'Fight Fire with Fire', '4:44', _a1),
      CancionData(2, 'Ride the Lightning', '6:36', _a2),
      CancionData(3, 'For Whom the Bell Tolls', '5:09', _a3),
      CancionData(4, 'Fade to Black', '6:57', _a4),
      CancionData(5, 'Trapped Under Ice', '4:03', _a5),
      CancionData(6, 'Escape', '4:23', _a6),
      CancionData(7, 'Creeping Death', '6:36'),
      CancionData(8, 'The Call of Ktulu', '8:53'),
    ],
  ),

  const AlbumData(
    id: 15,
    nombre: 'Metallica (The Black Album)',
    artista: 'Metallica',
    ano: '1991',
    genero: 'Heavy Metal / Hard Rock',
    descripcion:
        'El álbum más vendido de metal en la historia. Metallica simplificó su sonido sin perder potencia, llegando a un público masivo con Enter Sandman y Nothing Else Matters.',
    imagenUrl: '${_imgs}metallica_black.jpg',
    calificacionPromedio: 4.8,
    totalResenas: 13500,
    canciones: [
      CancionData(1, 'Enter Sandman', '5:31', _a1),
      CancionData(2, 'Sad but True', '5:24', _a2),
      CancionData(3, 'Holier Than Thou', '3:47', _a3),
      CancionData(4, 'The Unforgiven', '6:27', _a4),
      CancionData(5, 'Wherever I May Roam', '6:42', _a5),
      CancionData(6, "Don't Tread on Me", '3:59', _a6),
      CancionData(7, 'Through the Never', '4:04'),
      CancionData(8, 'Nothing Else Matters', '6:28'),
      CancionData(9, 'Of Wolf and Man', '4:16'),
      CancionData(10, 'The God That Failed', '5:05'),
    ],
  ),
];

// ════════════════════════════════════════════════════════════════
// ARTISTAS
// ════════════════════════════════════════════════════════════════
final List<ArtistaData> artistasQuemados = [
  ArtistaData(
    id: 1,
    nombre: 'Alice in Chains',
    albumes: [albumsQuemados[0], albumsQuemados[1], albumsQuemados[2]],
  ),
  ArtistaData(
    id: 2,
    nombre: 'Queen',
    albumes: [albumsQuemados[3], albumsQuemados[4], albumsQuemados[5]],
  ),
  ArtistaData(
    id: 3,
    nombre: 'Pink Floyd',
    albumes: [albumsQuemados[6], albumsQuemados[7], albumsQuemados[8]],
  ),
  ArtistaData(
    id: 4,
    nombre: 'Black Sabbath',
    albumes: [albumsQuemados[12], albumsQuemados[13], albumsQuemados[14]],
  ),
  ArtistaData(
    id: 5,
    nombre: 'Metallica',
    albumes: [albumsQuemados[9], albumsQuemados[10], albumsQuemados[11]],
  ),
];

// ════════════════════════════════════════════════════════════════
// RESEnAS QUEMADAS
// ════════════════════════════════════════════════════════════════
final List<ResenaData> resenasQuemadas = [
  const ResenaData(
    autorNombre: 'Alex Morrison',
    autorUsuario: '@alexmrrsn',
    texto:
        'Bohemian Rhapsody alone makes this one of the greatest albums ever recorded. Timeless.',
    calificacion: 5.0,
    fecha: '15 abr 2025',
  ),
  const ResenaData(
    autorNombre: 'Sofia Ruiz',
    autorUsuario: '@sofiaruiz',
    texto:
        'Un álbum que marcó una era entera del rock. Imposible no amarlo de principio a fin.',
    calificacion: 4.5,
    fecha: '2 mar 2025',
  ),
  const ResenaData(
    autorNombre: 'Carlos Medina',
    autorUsuario: '@cmedina_',
    texto:
        'Absolutamente épico. Cada pista es una obra maestra por derecho propio.',
    calificacion: 5.0,
    fecha: '28 ene 2025',
  ),
];

// ════════════════════════════════════════════════════════════════
// USUARIOS QUEMADOS (para búsqueda)
// ════════════════════════════════════════════════════════════════
final List<UsuarioData> usuariosQuemados = [
  const UsuarioData(
      id: '1',
      nombre: 'Alex Morrison',
      username: '@alexmrrsn',
      fotoUrl: '',
      seguidores: 89,
      siguiendo: 127),
  const UsuarioData(
      id: '2',
      nombre: 'Sofia Ruiz',
      username: '@sofiaruiz',
      fotoUrl: '',
      seguidores: 312,
      siguiendo: 88),
  const UsuarioData(
      id: '3',
      nombre: 'Carlos Medina',
      username: '@cmedina_',
      fotoUrl: '',
      seguidores: 45,
      siguiendo: 67),
  const UsuarioData(
      id: '4',
      nombre: 'María García',
      username: '@mariagarcia',
      fotoUrl: '',
      seguidores: 203,
      siguiendo: 156),
  const UsuarioData(
      id: '5',
      nombre: 'Juan Pérez',
      username: '@juanpmusic',
      fotoUrl: '',
      seguidores: 78,
      siguiendo: 92),
  const UsuarioData(
      id: '6',
      nombre: 'Valentina López',
      username: '@vlopezbeat',
      fotoUrl: '',
      seguidores: 431,
      siguiendo: 210),
  const UsuarioData(
      id: '7',
      nombre: 'Diego Fernández',
      username: '@diegorock',
      fotoUrl: '',
      seguidores: 129,
      siguiendo: 74),
];
