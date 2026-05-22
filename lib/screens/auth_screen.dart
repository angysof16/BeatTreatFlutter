import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';
import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  final _emailLoginCtrl = TextEditingController();
  final _passLoginCtrl  = TextEditingController();
  String? _loginError;
  bool _rememberMe = false;

  final _nombreCtrl   = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _emailRegCtrl = TextEditingController();
  final _passRegCtrl  = TextEditingController();
  final _paisCtrl     = TextEditingController();
  final _bioCtrl      = TextEditingController();
  String? _registroError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedTab = _tabController.index);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailLoginCtrl.text.isEmpty || _passLoginCtrl.text.isEmpty) {
      setState(() => _loginError = 'Completa todos los campos');
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void _registrar() {
    if (_nombreCtrl.text.isEmpty || _usernameCtrl.text.isEmpty ||
        _emailRegCtrl.text.isEmpty || _passRegCtrl.text.isEmpty) {
      setState(() => _registroError = 'Completa los campos obligatorios (*)');
      return;
    }
    if (_passRegCtrl.text.length < 6) {
      setState(() => _registroError = 'La contrasena debe tener al menos 6 caracteres');
      return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeatTreatColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              _Logo(),
              const SizedBox(height: 36),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _TabButton(texto: 'Sign In', selected: _selectedTab == 0, onTap: () {
                    _tabController.animateTo(0);
                  }),
                  const SizedBox(width: 32),
                  _TabButton(texto: 'Sign Up', selected: _selectedTab == 1, onTap: () {
                    _tabController.animateTo(1);
                  }),
                ],
              ),
              const SizedBox(height: 32),

              SizedBox(
                height: _selectedTab == 0 ? 340 : 480,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildLogin(),
                    _buildRegistro(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogin() {
    return Column(
      children: [
        DarkTextField(hint: 'Email', icon: Icons.mail_outline, controller: _emailLoginCtrl),
        const SizedBox(height: 14),
        DarkTextField(hint: 'Contrasena', icon: Icons.lock_outline, obscure: true, controller: _passLoginCtrl),
        const SizedBox(height: 14),

        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (v) => setState(() => _rememberMe = v ?? false),
              activeColor: BeatTreatColors.purple60,
            ),
            Text('Recuerda mi usuario',
              style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 14)),
          ],
        ),

        if (_loginError != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: BeatTreatColors.error.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_loginError!,
              style: GoogleFonts.spaceGrotesk(color: BeatTreatColors.error, fontSize: 13)),
          ),
        ],

        const SizedBox(height: 20),
        PurpleButton(label: 'Iniciar Sesión', onTap: _login),
        const SizedBox(height: 20),
        Text('¿Olvidaste tu contrasena?',
          style: GoogleFonts.spaceGrotesk(color: BeatTreatColors.textGray, fontSize: 14)),
      ],
    );
  }

  Widget _buildRegistro() {
    return Column(
      children: [
        DarkTextField(hint: 'Nombre completo *', icon: Icons.person_outline, controller: _nombreCtrl),
        const SizedBox(height: 10),
        DarkTextField(hint: 'Nombre de usuario *', icon: Icons.alternate_email, controller: _usernameCtrl),
        const SizedBox(height: 10),
        DarkTextField(hint: 'Email *', icon: Icons.mail_outline, controller: _emailRegCtrl),
        const SizedBox(height: 10),
        DarkTextField(hint: 'Contrasena * (mín. 6 caracteres)', icon: Icons.lock_outline, obscure: true, controller: _passRegCtrl),
        const SizedBox(height: 10),
        DarkTextField(hint: 'País (opcional)', icon: Icons.place_outlined, controller: _paisCtrl),
        const SizedBox(height: 10),
        DarkTextField(hint: 'Biografía (opcional)', icon: Icons.info_outline, controller: _bioCtrl, maxLines: 2),

        if (_registroError != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: BeatTreatColors.error.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(_registroError!,
              style: GoogleFonts.spaceGrotesk(color: BeatTreatColors.error, fontSize: 13)),
          ),
        ],

        const SizedBox(height: 16),
        PurpleButton(label: 'Regístrate', onTap: _registrar),
        const SizedBox(height: 12),

        GestureDetector(
          child: Container(
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('G', style: GoogleFonts.outfit(color: const Color(0xFF4285F4), fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Text('Sign up with Google',
                  style: GoogleFonts.spaceGrotesk(color: Colors.white70, fontSize: 15)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//  logo 
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/beattreat.png',
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [BeatTreatColors.purple60, BeatTreatColors.purpleDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.music_note, color: Colors.white, size: 30),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Text('BeatTreat',
          style: GoogleFonts.jaro(fontSize: 32, fontWeight: FontWeight.normal, color: Colors.white)),
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  final String texto;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({required this.texto, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(texto, style: GoogleFonts.spaceGrotesk(
            fontSize: 18, fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            color: selected ? Colors.white : BeatTreatColors.textGray,
          )),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 70, height: 3,
            decoration: BoxDecoration(
              color: selected ? BeatTreatColors.purple60 : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}