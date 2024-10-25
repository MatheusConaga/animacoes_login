import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tela_login_animada/botaoAnimado.dart';
import 'package:tela_login_animada/inputPersonalizado.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _animationBlur;
  late Animation<double> _animationFade;
  late Animation<double> _animationSize;

    @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animationBlur = Tween<double>(
      begin: 5,
      end: 0,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease
    ));

    _animationFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutQuint
    ));

    _animationSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate
    ));

    _animationController.forward();

  }
  @override
  void dispose() {
      _animationController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {

      timeDilation = 10;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                  animation: _animationBlur,
                  builder: (context,widget){
                    return Container(
                      height: 400,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("images/fundo.png"),
                            fit: BoxFit.fill
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: _animationBlur.value,
                          sigmaY: _animationBlur.value,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10,
                              child: FadeTransition(
                                  opacity: _animationFade,
                                child: Image.asset("images/detalhe1.png"),
                              ),
                            ),
                            Positioned(
                              left: 50,
                              child: FadeTransition(
                              opacity: _animationFade,
                              child: Image.asset("images/detalhe2.png"),
                            ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: Column(
                  children: [
                    AnimatedBuilder(
                        animation: _animationSize,
                        builder: (context,widget){
                            return Container(
                              width: _animationSize.value,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 15,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  InputCustomizado(hint: "Email",),
                                  InputCustomizado(hint: "Senha",obscure: true,icon: Icon(Icons.lock),),
                                ],
                              ),
                            );
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BotaoAnimado(

                      controller: _animationController,

                    ),
                    SizedBox(height: 10,),
                    FadeTransition(
                      opacity: _animationFade,
                      child: Text("Esqueci minha senha!",
                        style: TextStyle(
                            color: Color.fromRGBO(255, 100, 127, 1),
                            fontWeight: FontWeight.bold
                        ),)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


