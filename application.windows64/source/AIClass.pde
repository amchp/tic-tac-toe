
int whatCount = 0;

int[] findBestMove(int[][] aiBoard){
  int turn = 1;
  int[][] moves = findMoves(aiBoard);
  int[] container = new int[moves.length];
  for(int i = 0; i < moves.length; i++){
       int result = minMaxAlgorithm(aiBoard, moves[i], turn, 0);
       if(result == 2){
         container[i] = result;
         break;
       }
       container[i] = result;
       
   }
   int index = 0;
   int max = container[0];
   for(int i = 1; i < container.length; i++){
     if(container[i] > max){
       index = i;
       max = container[i];
     }
   }
   return moves[index];
}

int[][] findMoves(int[][] aiBoard){
  int count = 0;
  for(int[] row : aiBoard){
    for(int col : row){
      if(col == 0){
        count++;
      }
    }
  }
  int[][] moves = new int[count][2];
  count = 0;
  for(int i = 0; i < aiBoard.length; i++){
    for(int j = 0; j < aiBoard[i].length; j++){
      if(aiBoard[i][j] == 0){
        moves[count][0] = i;
        moves[count][1] = j;
        count++;
      }
    }
  }
  return moves;
}

int minMaxAlgorithm(int[][] aiBoard, int[] move, int turn, int depth){
  int[][] newBoard = makeNewBoard(aiBoard);
  newBoard[move[0]][move[1]] = turn;
  //Result
  if(evaluate(newBoard)){
    if(turn == 1){
      return 1000 - depth;
    }
    else{
      return 0 - depth;
    }
  }
  if(checkDraw(newBoard)) return 500 - depth;
  //Min
  depth++;
  if(turn == 1){
    turn = 2;
    int[][] moves = findMoves(newBoard);
    int[] container = new int[moves.length];
    for(int i = 0; i < moves.length; i++){
      container[i] = minMaxAlgorithm(newBoard, moves[i], turn, depth);
    }
    return min(container);
  }
  //Max
  else{
    turn = 1;
    int[][] moves = findMoves(newBoard);
    int[] container = new int[moves.length];
    for(int i = 0; i < moves.length; i++){
      container[i] = minMaxAlgorithm(newBoard, moves[i], turn, depth);
    }
    return max(container);
  }
}

int[][] makeNewBoard(int[][] oldBoard){
  int[][] newBoard = new int[oldBoard.length][oldBoard[0].length];
  for(int i = 0; i < oldBoard.length; i++){
    for(int j = 0; j < oldBoard[0].length; j++){
      newBoard[i][j] = oldBoard[i][j];
    }
  }
  return newBoard;
}

boolean evaluate(int[][] checkBoard){
  //columbs
  for(int i = 0; i < checkBoard.length; i++){
    int count1 = 0;
    int count2 = 0;
    for(int j = 0; j < checkBoard[i].length; j++){
      if(checkBoard[i][j] == 1){
        count1++;
      }
      else if(checkBoard[i][j] == 2){
        count2++;
      }
    }
    if(count1 == 3 || count2 == 3){
      return true;
    }
  }
  //Row
  for(int i = 0; i < checkBoard.length; i++){
    int count1 = 0;
    int count2 = 0;
    for(int j = 0; j < checkBoard[i].length; j++){
      if(checkBoard[j][i] == 1){
        count1++;
      }
      else if(checkBoard[j][i] == 2){
        count2++;
      }
    }
    if(count1 == 3 || count2 == 3){
      return true;
    }
  }
  //Diagonals
  if((checkBoard[0][0]  == 1 && checkBoard[1][1]  == 1 && checkBoard[2][2]  == 1) || (checkBoard[0][0]  == 2 && checkBoard[1][1]  == 2 && checkBoard[2][2]  == 2)){
    return true;
  }else if((checkBoard[2][0]  == 1 && checkBoard[1][1]  == 1 && checkBoard[0][2]  == 1) || (checkBoard[2][0]  == 2 && checkBoard[1][1]  == 2 && checkBoard[0][2]  == 2)){
    return true;
  }
  return false;
}


boolean checkDraw(int[][] drawBoard){
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
