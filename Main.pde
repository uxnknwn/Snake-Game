// Snake Game - Java-based Processing project

Snake snake;
Apple apple;
Game game;

int gridSize = 40;

void update() {
   if (game.isGameOver()) {
     return;
   }

  snake.update();
  
  if (apple.isEaten(snake)) {
    snake.grow();
    apple.respawn();
    game.incrementScore();
  }
  
  game.updateGameOver(snake);
}

void display() {
  apple.display();
  snake.display();
  game.display();
}

void restart() {
  snake = new Snake(gridSize);
  apple = new Apple(gridSize);
  game = new Game();
}

void setup() {
  size(600, 600);

  snake = new Snake(gridSize);
  apple = new Apple(gridSize);
  game = new Game();
}

void draw() {
  background(0);
  update();
  display();
}

void keyPressed() {
  if (game.isGameOver()) {
    if (key == ' '){
      restart();
    } else {
      return;
    }
  }
  
  if (keyCode == UP || key == 'w' || key == 'W') {
    snake.changeDirection(0, -1);
  } else if (keyCode == DOWN || key == 's' || key == 'S') {
    snake.changeDirection(0, 1);
  } else if (keyCode == LEFT || key == 'a' || key == 'A') {
    snake.changeDirection(-1, 0);
  } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
    snake.changeDirection(1, 0);
  }
}
