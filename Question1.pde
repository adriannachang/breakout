//Variables
final int bricksPerRow = 10;
final int numRows = 8;
int brickWidth;
int brickHeight;

int[] brickX = new int[bricksPerRow];
int[] brickY = new int[numRows];
color[] brickColor = {color(255, 0, 0), color(255, 153, 51), color(0, 255, 0), color(255, 255, 0)};
//Track whether brick should be displayed or not
boolean[][] brickVisible = new boolean[bricksPerRow][numRows];

final int paddleWidth = 125;
final int paddleHeight = 25;
int paddleX;
int paddleY;

int gameBallX;
int gameBallY;
float gameBallSpeedX = -1.95;
float gameBallSpeedY = 1.95;

boolean gameStart = false;
boolean gameOver = false;
boolean redOrangeRows = false;
boolean setOrangeRedSpeed = false;
boolean winGame = false;


int playerScore = 0;
int playerLives = 3;
int ballHits = 0;

PFont textFont;
void setup()
{
  size(800, 700);
  
  brickWidth = width/bricksPerRow;
  brickHeight = 25;
  
  int counter = 0;
  
  while (counter < numRows)
  {
    int brickNum = 0;
    while (brickNum < bricksPerRow)
    {
      brickX[brickNum] = brickWidth*brickNum;
      brickY[counter] = brickHeight*counter;
      brickVisible[brickNum][counter] = true;
      brickNum ++;
    }
    counter ++;
  }
   
  paddleX = width/2;
  paddleY = height*11/12;
  
  textFont = loadFont("Serif-48.vlw");
  textFont(textFont, 30);
  textAlign(CENTER, CENTER);
}

void draw()
{
  background(255);
  drawBricks();
  drawPaddle();

  if (gameStart && !gameOver && !winGame)
  {
      moveBall();
  }
  else if (!gameOver && !winGame)
  {
      setUpBall();
  }
  else if (!winGame)
  {
    text("GAME OVER", width/2, height/2);
  }
  else
  {
    text("YOU WIN!", width/2, height/2);
  }
    
  displayStats();
  println("gameBallSpeedX: "+gameBallSpeedX );
  println("game ball SpeedY: "+gameBallSpeedY);
  println("BALl hits: "+ballHits);


}

void drawBricks()
{
  int counter = 0;
  int colorToFill = 0;
  //Used to see when all of the bricks have been hit
  int bricksHit = 0;
  rectMode(CORNER);
  while (counter < numRows)
  {
    int brickNum = 0;
    fill(brickColor[colorToFill]);
    while (brickNum < bricksPerRow)
    {
        if (brickVisible[brickNum][counter])
        {
          rect(brickX[brickNum], brickY[counter], brickWidth, brickHeight);
        }
        else
        {
          bricksHit ++;
        }
        brickNum ++;
    }
    counter ++;
    if (counter % 2 == 0)
    {
      colorToFill ++;
    }
  }  
  
  if (bricksHit == 80)
  {
    winGame = true;
  }
}
void drawPaddle()
{
  rectMode(CENTER);
  fill(0);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

void setUpBall()
{
 fill(0);
  text("Use left and right arrows to move.", width/2, height/2);
  text("Press SPACE to start.", width/2, height/2 + 50);
  //Local variable for size of ball
  int gameBallSize = 25;
  
  gameBallX = width/2;
  gameBallY = height*11/12 - gameBallSize;
  
  //Ball fill = blue
  fill(0, 0, 255);
  ellipse(gameBallX, gameBallY, gameBallSize, gameBallSize);
}
void moveBall()
{
  //Local variable for size of ball
  int gameBallSize = 25;
  
  
  fill(0, 0, 255);
  ellipse(gameBallX, gameBallY, gameBallSize, gameBallSize);

  gameBallX -= gameBallSpeedX;
  gameBallY -=  gameBallSpeedY;
  
  if (gameBallX+gameBallSize/2 >= width || gameBallX-gameBallSize/2 <= 0)
  {
    gameBallSpeedX *= -1;
  }
  
  if (((gameBallX >= paddleX - paddleWidth/2) && (gameBallX <= paddleX + paddleWidth/2) && 
      (gameBallY + gameBallSize/2 >= paddleY - paddleHeight/2) && (gameBallY-gameBallSize/2 <= paddleY + paddleHeight/2)) || (gameBallY+ gameBallSize/2 <= 0)) 
      {
        gameBallSpeedY *= -1;
      }
   
  else if( gameBallY - gameBallSize/2 >= height)
  {
    if (playerLives == 0)
    {
      gameOver = true;
    }
    else
    {
      gameStart = false;
      paddleX = width/2;
      playerLives --;
      ballHits = 0;
      resetSpeed();
    }
  }
      
      
  int counter = 0;

  while (counter < numRows)
  {
    int counter2 = 0;
    while (counter2 < bricksPerRow)
    { 
      if (((gameBallX >= brickX[counter2]) && (gameBallX <= brickX[counter2] + brickWidth))
      && ((gameBallY >= brickY[counter]) && (gameBallY <= brickY[counter] + brickHeight)) && (brickVisible[counter2][counter] == true))
      {
        brickVisible[counter2][counter] = false;
        gameBallSpeedY *= -1;
        println("hit a brick");
        
        if (counter == 0 || counter == 1)
        {
          playerScore += 7;
          redOrangeRows = true;
        }
        
        else if (counter == 2 || counter == 3)
        {
          playerScore += 5;
          redOrangeRows = true;
        }
        
        else if (counter == 4 || counter == 5)
        {
          playerScore += 3;
        }
        
        else if (counter == 6 || counter == 7)
        {
          playerScore ++;
        }
        
        ballHits ++;
        updateBallSpeed();
      }
      counter2 ++;
      
    }
    counter ++;
    
  }
  
  
}
 

void keyPressed()
{  
    switch(keyCode)
    {
      case LEFT:
      if (gameStart && paddleX - paddleWidth/2 > 0)
      {
        paddleX -= 10;
      }
      break;
      
      case RIGHT:
      if (gameStart && paddleX + paddleWidth/2 < width)
      {    
        paddleX += 10;
      }
      break;
      
      case ' ':  
      gameStart = true;
      break;
      
      default:
      break;
  }
}

void displayStats()
{
  fill(0);
  text("Score: " + playerScore, width*7/8, height*11/12);
  text("Lives: " + playerLives, width/8, height*11/12);
}

void updateBallSpeed()
{
  
  if (ballHits == 4)
  {
    gameBallSpeedX *= 1.05;
    gameBallSpeedY *= 1.05;
    println("GOOO!!!");
  }
  
  else if (ballHits == 12)
  {
    gameBallSpeedX *= 1.1;
    gameBallSpeedY *= 1.1;
    println("change speed");
  }
  
  else if (redOrangeRows && !setOrangeRedSpeed)
  {
    setOrangeRedSpeed = true;
    gameBallSpeedX *= 1.1;
    gameBallSpeedY *= 1.1;
  }
  
  
}

void resetSpeed()
{
  redOrangeRows = false;
  setOrangeRedSpeed = false;
  gameBallSpeedX = -1.95;
  gameBallSpeedY = 1.95;
}