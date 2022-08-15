import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const String PLAYER_X = "X";
  static const String PLAYER_Y = "O";

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;
  @override
  void initState() {
    initializedGame();
    super.initState();
  }

  void initializedGame() {
    currentPlayer = PLAYER_X;
    gameEnd = false;
    occupied = [
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      ""
    ]; //Neuf cases vides au depart
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_headerText(), _gameContainer(), _restartButton()],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
      const  Text(
          "TIC TAC TOE",
          style:  TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        Text(
          " $currentPlayer  turn",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate:
            const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        //Quand on clique sur le bouton
        setState(() {
          if (gameEnd || occupied[index].isNotEmpty) {
            return;
          }
          occupied[index] = currentPlayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color:occupied[index].isEmpty
            ? Colors.black26
             : occupied[index] == PLAYER_X
                 ? Colors.blue
                : Colors.orangeAccent,
          borderRadius: BorderRadius.circular(15.0)),
        margin: const EdgeInsets.all(8),
        // color: occupied[index].isEmpty
        //     ? Colors.black26
        //     : occupied[index] == PLAYER_X
        //         ? Colors.blue
        //         : Colors.orangeAccent,
        child: Center(
            child: Text(
          occupied[index],
          style: const TextStyle(fontSize: 50, color: Colors.red),
        )),
      ),
    );
  }

  changeTurn() {
    if (currentPlayer == PLAYER_X) {
      currentPlayer = PLAYER_Y;
    } else {
      currentPlayer = PLAYER_X;
    }
  }

  checkForWinner() {
    //Definir les positions gagnantes du jeu

    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];

      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          //TOUTES LES CASES SONT EGALES
          showGameOverMessage('Player $playerPosition0 won');
          gameEnd = true;
          return;
        }
      }
    }
  }

  showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
        content: Text(
      "Game Over $message",
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 20, ),
    )));
  }

  _restartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        
          onPressed: () {
            setState(() {
              initializedGame();
            });
          },
          child: const Text("Recommencer")),
    );
  }

  checkForDraw() {
    if (gameEnd) {
      return;
    }
    bool draw = true;
    for (var occupiedPlayer in occupied) {
      if (occupiedPlayer.isEmpty) {
        //at least one is Emptey , not all are fill
        draw = false;
      }
    }
  }
}
