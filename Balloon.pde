// This class is intended to be used for instantiating a balloon object. It is hoped that eventually, the balloon object will be placed into an array in the main class, and the methods will be 
// called when it is accessed by the program.
class Balloon {
  
  // These are the private variables, which are only capable of being used WITHIN the class itself. The xPosition and the yPosition is the main concern for the class
  // as it dictates the position of each balloon object.
  private float xPos;
  private float yPos;
  private float speed;
  private float radius;
  private float alpha;
  private float speedX;
  
  // This is the constructor of the class itself. This will establish the values of any variables that will be used throughout the class.
  // To start off, inputX refers to the xPOsition of the balloon.
  // inputY refers to the yPOsition of the balloon.
  // speed refers to how fast the balloon is rising up into the air by
  // radius signifies the radius of the balloon (this variable determines the size)
  // alpha refers to the transparency
  // speedX refers to how fast the balloon is moving left or right on the screen
  Balloon(float inputX, float inputY, float speed, float radius, float alpha, float speedX){
    this.xPos = inputX;
    this.yPos = inputY;
    this.speed = speed;
    this.radius = radius;
    this.alpha = alpha;
    this.speedX = speedX;
  }
  
  // I want to be able to create a move() function inside the Balloon class, in order to move the balloon as it goes up.
  void move(String difficulty){
  
    // One has to create a circle that will represent each balloon as it appears on the screen.
    // Filling in the balloon with a red colour.
    fill(255, 0, 0, alpha);
    // Using the stroke function, we make sure that once the balloon is clicked, we can make it disappear.
    stroke(0, alpha);
    // Essentially, balloon is formed by using a circle drawing as well as a line to represent the string of the balloon. It is not known whether any images may be added in substitution.
    circle(xPos, yPos, radius);
    line(xPos, (yPos + radius/2), xPos, (yPos + radius/2 + 50));
    // Once the balloons emerge from the screen, they are to rise up to the top.
    yPos -= speed;
    
    // If the difficulty is set to Hard, we are going to move the balloons to the right using the speed that we have passed through as an argument.
    if (difficulty == "HARD"){
      xPos = xPos + speedX;
      // We check whether the balloons have passed the confines of the canvas. If so, then the balloons are expected to ricochet back.
      if (xPos >= width-radius || xPos <= radius){
        speedX = -speedX;
      }
      // Otherwise, if the difficulty is set to Medium, we employ a smaller speed for the x-axis.
    } else if (difficulty == "MEDIUM"){
      xPos = xPos + (speedX - 3);
      // Same idea as demonstrated above.
      if (xPos >= width-radius || xPos <= radius){
        speedX = -speedX;
      }
    }
  }
 
 // This is a mutator method that intends to change the alpha (transparency) of the actual colour
  void changeAlpha(float alpha){
    // We reference the parameter as the same variable that we had established as a private
     this.alpha = alpha;
  }
  
  // Once the balloons reach the top, we want to reset all of the balloons back to where they came from.
  void changeYPos(float yPos){
    this.yPos = yPos;
  }
  
  // Furthermore, this is a mutator method that intends to change the speed of the actual balloon
  void changeSpeed(float speed){
     this.speed = speed; 
  }
  
 // This is an accessor method that returns the yPosition of the balloon; this is extremely important in deciding whether the player lsot (if any balloon passed the top of the screen)
  float returnYPos(){
    return yPos; 
  }

  // This is an acccessor method that returns the xPosition of the balloon; the intention is to see where the balloon is; 
  float returnXPos(){
    return xPos; 
  }

  // This accessor method will return the transparency of the balloon.
  float returnAlpha(){
    return alpha;
  }
}