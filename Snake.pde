import java.util.ArrayList;

class Snake {

  ArrayList<PVector> body;
  ArrayList<PVector> previousBody;

  private int xDirection;
  private int yDirection;
  private int pendingGrowth = 1;
  private int currentFrame = 0;
  private int gridSize;
  
  private PImage headUp = loadImage("Assets/head_up.png");
  private PImage headLeft = loadImage("Assets/head_left.png");
  private PImage headRight = loadImage("Assets/head_right.png");
  private PImage headDown = loadImage("Assets/head_down.png");

  private int moveDelay = 8;

  Snake(int gridSize) {
    body = new ArrayList<PVector>();

    //body.add(new PVector((width / gridSize) / 2, (width / gridSize) / 2));
    body.add(new PVector(CENTER, CENTER));
    previousBody = copyBody(body);

    xDirection = 1;
    yDirection = 0;
    this.gridSize = gridSize;
  }

  void update() {
    currentFrame++;

    if (currentFrame < moveDelay) {
      return;
    }

    currentFrame = 0;
    previousBody = copyBody(body);

    PVector head = body.get(0);

    PVector newHead = new PVector(
      head.x + xDirection,
      head.y + yDirection
    );

    body.add(0, newHead);

    if (pendingGrowth > 0) {
      pendingGrowth--;
    } else {
      body.remove(body.size() - 1);
    }
  }

  void display() {

    fill(0, 255, 0);

    float amount = smoothAmount();

    for (int i = 0; i < body.size(); i++) {
      PVector part = body.get(i);
      PVector previousPart = i < previousBody.size() ? previousBody.get(i) : part;
      
      float xCoordinate = lerp(previousPart.x, part.x, amount) * gridSize;
      float yCoordinate = lerp(previousPart.y, part.y, amount) * gridSize;
    
      // Handle head image
      if (i == 0){
        image(getHeadImage(), xCoordinate, yCoordinate, gridSize, gridSize);
        continue;
      }
      
      stroke(#6482f9);
      fill(#6482f9);
      
      rect(
        xCoordinate,
        yCoordinate,
        gridSize,
        gridSize
      );
    }
  }

  void grow() {
    pendingGrowth++;
  }

  void changeDirection(int x, int y) {

    // Prevent reversing into itself
    if (x == -xDirection && y == -yDirection) {
      return;
    }

    xDirection = x;
    yDirection = y;
  }
  
  PImage getHeadImage(){
    if (xDirection == 1) {
      return headRight;
    } else if (xDirection == -1) {
      return headLeft;
    } else if (yDirection == -1) {
      return headUp;
    } else if (yDirection == 1) {
      return headDown;
    }
    
    return headUp;
  }

  boolean hitWall() {

    PVector head = body.get(0);

    return head.x < 0 ||
           head.x >= width / gridSize ||
           head.y < 0 ||
           head.y >= height / gridSize;
  }

  boolean hitSelf() {

    PVector head = body.get(0);

    for (int i = 1; i < body.size(); i++) {

      PVector part = body.get(i);

      if (head.x == part.x &&
          head.y == part.y) {
        return true;
      }
    }

    return false;
  }

  PVector getHead() {
    return body.get(0);
  }

  private float smoothAmount() {
    if (moveDelay <= 1) {
      return 1;
    }

    return constrain(currentFrame / (float)(moveDelay - 1), 0, 1);
  }

  private ArrayList<PVector> copyBody(ArrayList<PVector> source) {
    ArrayList<PVector> copy = new ArrayList<PVector>();

    for (PVector part : source) {
      copy.add(part.copy());
    }

    return copy;
  }
}
