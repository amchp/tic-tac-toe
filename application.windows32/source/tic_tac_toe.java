import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tic_tac_toe extends PApplet {

int[][] board = new int[3][3];
int player = 1;
int boardX, boardY;
//Main menu = 0 VS = 1 Computer = 2 Win = 3
int gameState = 0;
int aiPlayer = 1;
int previousGameState = 1; 


public void setup(){
   
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
public void draw(){
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
        if(board[i][j] == 1){
          //X's + or - 30 for X points: 30, 170, 230, 370, 430, 570
          line(i*200 + 30,j*200 + 30,(i + 1)*200 - 30,(j + 1)* 200 - 30 );
          line(i*200 + 30,(j + 1)* 200 - 30 ,(i + 1)*200 - 30,j*200 + 30);
        }else if(board[i][j] == 2){
          //Circle middle of square and size 150 points: 100, 300, 500
          circle((i+1)*200 - 100, (j+1)*200 - 100, 150);
        }
      }
    }
    if(checkWin()) gameState = 3;
    if(checkDraw()) gameState = 3;
  }
}

public void mousePressed(){
  if(gameState == 0){
    if(mouseX >= 265 && mouseX <= 265+55 && mouseY >= 210 && mouseY <= 210 +55){
      gameState = 1;
    }else if(mouseX >= 195 && mouseX <= 195+205 && mouseY >= 310 && mouseY <= 310 +55){
      gameState = 2;
      player = 2;
      board[0][0] = 1;
    }
  }
  else if(gameState == 1){
    //Game mouse
    gameMouse();
    previousGameState = 1;
  }else if(gameState == 2){
    //Mouse
    gameMouse();
    //AI
    int[] bestMove = findBestMove(board); 
    board[bestMove[0]][bestMove[1]] = 1;
    previousGameState = 2;
  }
  else if(gameState == 3){
    for(int i = 0; i < board.length; i++){
      for(int j = 0; j < board[i].length; j++){
          board[i][j] = 0;
      }
    }
    gameState = previousGameState;
  }
}

public void gameMouse(){
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
    if(board[boardX][boardY]  == 0){
      board[boardX][boardY] = player;
      if(gameState == 1){
        if(player == 1){
          player = 2;
        }else{
          player = 1;
        }
      }
    }
}

public boolean checkDraw(){
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
public boolean checkDraw(int[][] drawBoard){
  int count = 0;
  for(int i = 0; i < drawBoard.length; i++){
    for(int j = 0; j < drawBoard[i].length; j++){
      if(drawBoard[i][j] != 0){
        count++;
      }
    }
  }
  return count == 9;
}

public boolean checkWin(){
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


//AI program
public int evaluate(int b[][]) 
{ 
    // Checking for Rows for X or O victory. 
    for (int row = 0; row<3; row++) 
    { 
        if (b[row][0]==b[row][1] && 
            b[row][1]==b[row][2]) 
        { 
            if (b[row][0]==1) 
                return +10; 
            else if (b[row][0]==2) 
                return -10; 
        } 
    } 
  
    // Checking for Columns for X or O victory. 
    for (int col = 0; col<3; col++) 
    { 
        if (b[0][col]==b[1][col] && 
            b[1][col]==b[2][col]) 
        { 
            if (b[0][col]==1) 
                return +10; 
  
            else if (b[0][col]==2) 
                return -10; 
        } 
    } 
  
    // Checking for Diagonals for X or O victory. 
    if (b[0][0]==b[1][1] && b[1][1]==b[2][2]) 
    { 
        if (b[0][0]==1) 
            return +10; 
        else if (b[0][0]==2) 
            return -10; 
    } 
  
    if (b[0][2]==b[1][1] && b[1][1]==b[2][0]) 
    { 
        if (b[0][2]==1) 
            return +10; 
        else if (b[0][2]==2) 
            return -10; 
    } 
  
    // Else if none of them have won then return 0 
    return 0; 
}

public int minimax(int board[][], int depth, boolean isMax) 
{ 
    int score = evaluate(board); 
  
    // If Maximizer has won the game return his/her 
    // evaluated score 
    if (score == 10) 
        return score; 
  
    // If Minimizer has won the game return his/her 
    // evaluated score 
    if (score == -10) 
        return score; 
  
    // If there are no more moves and no winner then 
    // it is a tie 
    if (checkDraw(board)==false) 
        return 0; 
  
    // If this maximizer's move 
    if (isMax) 
    { 
        int best = -1000; 
  
        // Traverse all cells 
        for (int i = 0; i<3; i++) 
        { 
            for (int j = 0; j<3; j++) 
            { 
                // Check if cell is empty 
                if (board[i][j]==0) 
                { 
                    // Make the move 
                    board[i][j] = 1; 
  
                    // Call minimax recursively and choose 
                    // the maximum value 
                    best = max( best, 
                        minimax(board, depth+1, !isMax) ); 
  
                    // Undo the move 
                    board[i][j] = 0; 
                } 
            } 
        } 
        return best; 
 } 
  // If this minimizer's move 
   else
   { 
        int best = 1000; 
  
        // Traverse all cells 
        for (int i = 0; i<3; i++) 
        { 
            for (int j = 0; j<3; j++) 
            { 
                // Check if cell is empty 
                if (board[i][j]==0) 
                { 
                    // Make the move 
                    board[i][j] = 2; 
  
                    // Call minimax recursively and choose 
                    // the minimum value 
                    best = min(best, 
                           minimax(board, depth+1, !isMax)); 
  
                    // Undo the move 
                    board[i][j] = 0; 
                } 
            } 
        } 
        return best; 
    } 
}

public int[] findBestMove(int board[][]) 
{ 
    int bestVal = -1000; 
    int[] bestMove = new int[2]; 
    bestMove[0] = -1; 
    bestMove[1] = -1; 
  
    // Traverse all cells, evaluate minimax function for 
    // all empty cells. And return the cell with optimal 
    // value. 
    for (int i = 0; i<3; i++) 
    { 
        for (int j = 0; j<3; j++) 
        { 
            // Check if cell is empty 
            if (board[i][j]==0) 
            { 
                // Make the move 
                board[i][j] = 1; 
  
                // compute evaluation function for this 
                // move. 
                int moveVal = minimax(board, 0, false); 
  
                // Undo the move 
                board[i][j] = 0; 
  
                // If the value of the current move is 
                // more than the best value, then update 
                // best/ 
                if (moveVal > bestVal) 
                { 
                    bestMove[0] = i; 
                    bestMove[1] = j; 
                    bestVal = moveVal; 
                } 
            } 
        } 
    } 
   
    return bestMove; 
} 

class AIClass{
  int[] move = new int[2];
}

  public void settings() {  size(600,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tic_tac_toe" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
