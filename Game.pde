class Game {

  private boolean gameOver = false;
  private int score = 0;

  void updateGameOver(Snake snake) {
    if (snake.hitWall() || snake.hitSelf()) {
      gameOver = true;
    }
  }
  
  boolean isGameOver() {
    return gameOver;
  }
  
  void incrementScore() {
    score += 1;
  }

  void display() {
    fill(255);
    textSize(25);
    textAlign(LEFT, TOP);
    text("Score: " + score, 10, 10);

    if (gameOver) {
      fill(255, 0, 0);
      textAlign(CENTER, CENTER);
      textSize(50);
      text("GAME OVER", width / 2, height / 2);

      textSize(25);
      text("Press SPACE to Restart", width / 2, height / 2 + 50);
    }
  }
}
