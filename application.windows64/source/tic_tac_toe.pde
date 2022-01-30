int[][] board = new int[3][3];
int player = 1;
int boardX, boardY;
//Main menu = 0 VS = 1 Computer = 2 Win = 3
int gameState = 0;
int aiPlayer = 1;
int previousGameState = 1; 
boolean draw = false;


void setup(){
   size(600,600);
   background(43, 92, 252);
    textSize(32);
    textSize(80);
    strokeWeight(3);
    fill(250, 177, 30);
    text("TIC-TAC-TOE", 30, 100);
    textSize(40);
    stroke(250, 177, 30);
    fill(43, 92, 252);
    rect(265, 210, 55, 55, 7);
    rect(195, 310, 205, 55, 7);
    fill(250, 177, 30);
    text("VS", 270, 250);
    text("Computer", 200, 350);
}
void draw(){
  if(gameState == 0){
    background(43, 92, 252);
    textSize(32);
    textSize(80);
     strokeWeight(3);
    fill(250, 177, 30);
    text("TIC-TAC-TOE", 30, 100);
    textSize(40);
    stroke(250, 177, 30);
    fill(43, 92, 252);
    rect(265, 210, 55, 55, 7);
    rect(195, 310, 205, 55, 7);
    fill(250, 177, 30);
    text("VS", 270, 250);
    text("Computer", 200, 350);
  }else if(gameState == 1 || gameState == 2){
    background(43, 92, 252);
    strokeWeight(20);
    stroke(250, 177, 30);
    fill(43, 92, 252);
    line(200, 20, 200, 580);
    line(400, 20, 400, 580);
    line(20,200,580,200);
    line(20,400,580,400);
    for(int i = 0; i < board.length; i++){
      for(int j = 0; j < board[i].length; j++){
        if(board[j][i] == 1){
          //X's + or - 30 for X points: 30, 170, 230, 370, 430, 570
          line(i*200 + 30,j*200 + 30,(i + 1)*200 - 30,(j + 1)* 200 - 30 );
          line(i*200 + 30,(j + 1)* 200 - 30 ,(i + 1)*200 - 30,j*200 + 30);
        }else if(board[j][i] == 2){
          //Circle middle of square and size 150 points: 100, 300, 500
          circle((i+1)*200 - 100, (j+1)*200 - 100, 150);
        }
      }
    }
    if(checkWin()){gameState = 3; draw = false;}
    if(checkDraw()){gameState = 3; draw = true;}
  }else if(gameState == 3){
    if(!draw){
      stroke(250, 177, 30);
      fill(43, 92, 252);
      strokeWeight(3);
      rect(170, 260, 255, 50, 7);
      textSize(40);
      fill(250, 177, 30);
      text("Player " + str(player % 2 + 1) + " wins", 170, 300);
    }else{
      stroke(250, 177, 30);
      fill(43, 92, 252);
      strokeWeight(3);
      rect(245, 260, 102, 50, 7);
      textSize(40);
      fill(250, 177, 30);
      text("Draw", 245, 300);
    }
  }
}

void mousePressed(){
  if(gameState == 0){
    if(mouseX >= 265 && mouseX <= 265+55 && mouseY >= 210 && mouseY <= 210 +55){
      gameState = 1;
    }else if(mouseX >= 195 && mouseX <= 195+205 && mouseY >= 310 && mouseY <= 310 +55){
      gameState = 2;
      player = 1;
      int[] bestMove = findBestMove(board); 
      board[bestMove[0]][bestMove[1]] = player;
      player = 2;
    }
  }
  else if(gameState == 1){
    //Game mouse
    gameMouse();
    if(checkWin())return;
    if(checkDraw())return;
    previousGameState = 1;
  }else if(gameState == 2){
    //Mouse
    gameMouse();
    //AI
    if(checkWin())return;
    if(checkDraw())return;
    int[] bestMove = findBestMove(board); 
    board[bestMove[0]][bestMove[1]] = player;
    if(player == 1){
          player = 2;
        }else{
          player = 1;
        }
    previousGameState = 2;
  }
  else if(gameState == 3){
    for(int i = 0; i < board.length; i++){
      for(int j = 0; j < board[i].length; j++){
          board[i][j] = 0;
      }
    }
    gameState = previousGameState;
    if(gameState == 2 && player == 1){
      int[] bestMove = findBestMove(board); 
      board[bestMove[0]][bestMove[1]] = player;
      player = 2; 
    }
  }
}

void keyPressed(){
  if(key == ESC){
    for(int i = 0; i < board.length; i++){
      for(int j = 0; j < board[i].length; j++){
          board[i][j] = 0;
      }
    }
    gameState = 0;
    key = 0;
  }
}

void gameMouse(){
  //Mouse x movement
    if(mouseX >= 0 && mouseX < 200){
      boardX = 0;
    }else if(mouseX >= 200 && mouseX < 400){
      boardX = 1;
    }
    else if(mouseX >= 400 && mouseX <= 600){
      boardX = 2;
    }
    //mouseY movement
    if(mouseY >= 0 && mouseY < 200){
      boardY = 0;
    }else if(mouseY >= 200 && mouseY < 400){
      boardY = 1;
    }
    else if(mouseY >= 400 && mouseY <= 600){
      boardY = 2;
    }
    if(board[boardY][boardX]  == 0){
      board[boardY][boardX] = player;
      if(gameState == 1 || gameState == 2){
        if(player == 1){
          player = 2;
        }else{
          player = 1;
        }
      }
    }
}

boolean checkDraw(){
  int count = 0;
  for(int i = 0; i < board.length; i++){
    for(int j = 0; j < board[i].length; j++){
      if(board[i][j] != 0){
        count++;
      }
    }
  }
  return count == 9;
}

boolean checkWin(){
  //columbs
  for(int i = 0; i < board.length; i++){
    int count1 = 0;
    int count2 = 0;
    for(int j = 0; j < board[i].length; j++){
      if(board[i][j] == 1){
        count1++;
      }
      else if(board[i][j] == 2){
        count2++;
      }
    }
    if(count1 == 3 || count2 == 3){
      return true;
    }
  }
  //Row
  for(int i = 0; i < board.length; i++){
    int count1 = 0;
    int count2 = 0;
    for(int j = 0; j < board[i].length; j++){
      if(board[j][i] == 1){
        count1++;
      }
      else if(board[j][i] == 2){
        count2++;
      }
    }
    if(count1 == 3 || count2 == 3){
      return true;
    }
  }
  //Diagonals
  if((board[0][0]  == 1 && board[1][1]  == 1 && board[2][2]  == 1) || (board[0][0]  == 2 && board[1][1]  == 2 && board[2][2]  == 2)){
    return true;
  }else if((board[2][0]  == 1 && board[1][1]  == 1 && board[0][2]  == 1) || (board[2][0]  == 2 && board[1][1]  == 2 && board[0][2]  == 2)){
    return true;
  }
  return false;
}
