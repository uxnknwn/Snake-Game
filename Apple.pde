class Apple {

  private PImage appleIMG = loadImage("Assets/apple.png");
    
  private int x;
  private int y;
  private int gridSize;

  Apple(int gridSize) {
    this.gridSize = gridSize;
    respawn();
  }

  void respawn() {
    x = (int)random(width / gridSize);
    y = (int)random(height / gridSize);
  }

  void display() {
    fill(255, 0, 0);
    
    float xCoordinate = x * gridSize;
    float yCoordinate = y * gridSize;
    
    image(appleIMG,xCoordinate, yCoordinate, gridSize, gridSize);
  }

  boolean isEaten(Snake snake) {

    PVector head = snake.getHead();

    return head.x == x && head.y == y;
  }
}
