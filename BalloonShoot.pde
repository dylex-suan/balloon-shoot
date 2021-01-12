/*
Title of Project: Balloon Shoot
Name: Dylex Suan
Date: January 7, 2020
Description: The purpose of the game is to shoot balloons as they emerge from the bottom, and to obtain the highest score in one sitting. The user will have multiple difficulties from which he or she 
can choose, and depending on the difficulty of the game, the balloons may move faster incrementally in order to keep up with the amount of balloons being shot. 
As well, the user will experience in the higher levels that the balloons tend to move a lot more erratically (for instance, in the MEDIUM and HARD levels, the balloons will move from side to side,
and will make it more difficult for the user to actually shoot down some of the balloons). Because of how many balloons are being generated, it is possible that the game may lag somewhat because of the generation of the balloons.
*/

// Create an array to store all of the balloon objects, so that we can access them later in the code when we need them. The maximum amount of balloons
// that one could possibly have at any time is determined by maxBalloons, which at this point, could change depending on the difficulty.
int maxBalloons = 20;
Balloon[] allBalloons = new Balloon[maxBalloons];

// I set a counter for the balloon objects, so that we can roll through each index of the array and establish the properties of an object (or instantiate the object, if there is no object to begin with)
int ballCount = 0;

// As for now, the balloons will be set as circles, so there has to be a radius with which to define the size of the circle.
float radius = 50;

// For now, I would like to set the speed in the main class so that I can change it in other methods.
float speed;

// This will represent the score of the game that the user is playing.
int score = 0;

// The font variable will store the type of font that I intend to use throughout the code.
PFont font;

// I want to make sure that the title stays on the screen until the user clicks on the multiple difficulties.
boolean onTitleScreen = true;

// I also want to see whether we need to display the scoreboard (if the user is on the title screen, it is quite unnecessary)
boolean displayScore = false;

// We need to check to see whether the user has played this game before.
boolean playedBefore = false;

// If the player has lost, the loseScreen will apepar up on the background.
boolean loseScreen = false;

// We need to check what kind of difficulty the user has selected.
String difficulty = "";

// I need to overlap the balloons, the background, and the scoreboard on here, so I will be using PGraphics.
// Layer 1 will represent the background.
// Layer 2 will represent the balloons.
// Layer 3 will represent the scoreboard.
PGraphics layer1;
PGraphics layer2;
PGraphics layer3;

// This will act as the clouds for the game. An image will be uploaded.
PImage cloudImage;

// The setup of the program establishes what the program would appear like before the program starts drawing everything.
void setup(){
  
  // I changed the screen size so that it would act as a full screen rather than what was stated in my proposal which was 640 x 640 pixels.
  fullScreen();
  
  // For testing purposes. I want to make sure I have the correct background for the game.
  background(59, 168, 255);
  
  // I create all the layers in setup() so that I can eventually overlap the background.
  layer1 = createGraphics(width, height);
  layer2 = createGraphics(width, height);
  layer3 = createGraphics(width, height);
  
  // I wanted to upload a cloud image just in case I would be able to use it.
  cloudImage = loadImage("Cloud.png");
  
}

// This will be the main method where all of the methods will feed to (in other words, all of the functionalities will be drawn here).
void draw(){
  // In my proposal, I wanted to make a reticle and create another class in order to make note of where the cursor is when shooting down the balloons.
  // However, after having discovered this functionality in Processing, I decided to not implement a class reticle as it would be somewhat redundant.
  cursor(CROSS);
  // First of all, the user should most likely see the title screen before proceeding to the game.
  titleScreen();
  // If the user has not played before, the user will be directed to the tutorial.
  if (onTitleScreen == false && playedBefore == false){
    tutorial();
    // However, if the user has played the game before, the tutorial will not be shown.
  } else if (playedBefore == true){
    // Then, we follow the difficulty based on what the user has entered. So, for instance, if the user has clicked on "EASY",
    // then the user will obviously be directed to the easy game. If the user has clicked on "MEDIUM", then the user will be directed to the medium mode, and so on and so forth.
    if (difficulty.equals("EASY")){
      easy();
    } else if (difficulty.equals("MEDIUM")){
      medium();
    } else if (difficulty.equals("HARD")) {
      hard();
    }
  }   
}

// This method serves to provide functionality to the mouse as the user navigates through the game. While the user should be using the left clicker on the mouse,
// it's quite possible that even the right clicker can be used.
void mousePressed(){
  // I want to see whether the title should be kept on the screen first.
  if (onTitleScreen == true){
    // If the title is still kept on the screen, we need to check whether the user has clicked on the Easy button
    if (mouseX > (width/2 - 300) && mouseX < (width/2 + 300) && mouseY > (height/2 - 50) && mouseY < (height/2 + 50)){
      // The program then has to interpret that the user wants to play the game (we put a boolean to say that the Title Screen should no longer be displayed)
      // The difficulty now turns into EASY.
      difficulty = "EASY";
      // Otherwise, if the user clicks on the MEDIUM button, the user will be directed to play the MEDIUM version of the game.
    } else if (mouseX > (width/2 - 300) && mouseX < (width/2 + 300) && mouseY > (height/2 + 100) && mouseY < (height/2 + 200)) {
      difficulty = "MEDIUM";
      // Lastly, if the user clicks on the HARD button, then the user will be directed to play the HARD version of the game.
    } else if (mouseX > (width/2 - 300) && mouseX < (width/2 + 300) && mouseY > (height/2 + 250) && mouseY < (height/2 + 350)) {
      difficulty = "HARD";
    } 
    // The title screen should not longer be made true, and should simply go to the actual game.
    onTitleScreen = false;
  } else if (onTitleScreen == false && playedBefore == true) { 
    // The mousePressed() function can only be used once, so many conditionals will have to be used depending on the sort of situation.
    for (int i = 0; i < ballCount; i++){
      // Right now, if the user remains within the confines of any balloon and shoots the balloon down, the user will gain some points (in this case, the program will accord the user with 10 points per balloon)
      if (mouseY > (allBalloons[i].returnYPos() - radius) && mouseY < (allBalloons[i].returnYPos() + radius) && mouseX > (allBalloons[i].returnXPos() - radius) && mouseX < (allBalloons[i].returnXPos() + radius)){
        // While there may be some added functionality regarding this, the basis is that the balloon will disappear from the screen.
        allBalloons[i].changeYPos(height + ((random(100, 1000))));
        // The score will also increase by 10 to make sure that the user knows h/she has actually shot down the balloon
        if ((mouseY > (allBalloons[i].returnYPos() - radius - 5) && mouseY < (allBalloons[i].returnYPos() + radius + 5) && mouseX > (allBalloons[i].returnXPos() - radius - 5) && mouseX < (allBalloons[i].returnXPos() + radius + 5))){
          // Same as what was done before.
          allBalloons[i].changeYPos(height + ((random(100, 1000))));
          // The score will now increase by 50 instead of 10.
          score += 50;
        } else {
          // However, if the user cannot hit near the center of the balloon, the balloon itself would only increment by 10 points.
          score += 10;
        }
      // Otherwise, we check whether the user has actually shot a bullseye with the balloon (in other words, the user was able to match the mouse cursor directly in the center of the balloon). If so, we accord the user with more points.
      } 
    }
    // Otherwise, if the screen is not on the the title screen then, most likely the user is either at the lose screen or not.
    // I did comment this out because I did not want any other part of the code to be impacted but the importance of this was to create an exit screen.
    /*
    } else if (onTitleScreen == false && loseScreen == true) {
      // This was supposed to be intended for the tutorial. Ideally, when the user loses a game, the person would be asked whether they would want to play the game once again (as specified in the previous method).
      // If so, then they would click on the play button and choose their difficulty once again.
      if ((mouseX > (width/2 - 415) && mouseX < (width/2 + 415) && mouseY > (width/2 - 75) && mouseY < (width/2 + 75))){
        loseScreen = false;
      }
      */
      // If the user wants to play the game and he or she is on the tutorial, then the difficulty will carry on with the user.
    } else {
       if ((mouseX > (width/2 - 415) && mouseX < (width/2 + 415) && mouseY > (width/2 - 75) && mouseY < (width/2 + 75))){
         // Again, as stated above, we still need to carry the difficulty of the user's choice. So for instance, if the user clicked on the "EASY" button, then the difficulty that carries on with the game
         // will obviously be the "EASY" difficulty.
          if (difficulty.equals("EASY")){
            easy();
          } else if (difficulty.equals("MEDIUM")){
            medium();
          } else if (difficulty.equals("HARD")) {
            hard();
          } else {
            titleScreen();
          }
        // If the user has been on the tutorial before, then the user should have also played before.
       playedBefore = true;
    } 
  }
}

// This method will serve to be the basis of the title screen.
void titleScreen(){
 
  // Every single time that the program refers to the titleScreen, we must reset the background.
  background(59, 168, 255);
  // As well, the score will also be reset to account for this. The score will also not be seen in this case.
  scoreBoard(0);
  
  stroke(0);
  // I want to be able to establish the Title Screen of the game, and place that screen onto the canvas.
  font = loadFont("Ravie-48.vlw");
  // Then, I want to use the font that I loaded to print out the title of the game
  textFont(font);
  // The colour of the title will most likely be red.
  fill(255, 0, 0);
  // I want to then establish the text size of my code.
  textSize(120);
  // The text should be aligned towards the center of the text box.
  textAlign(CENTER, CENTER);
  // Finally, I decide what the text is as well as where it is located in relation to the canvas.
  text("Balloon Shoot", width/2, height/6);
  
  // The colour of the rectangle will be green (for the easy difficulty)
  // Creating the Easy box
  fill(#43DE4C);
  rectMode(CENTER);
  rect(width/2, height/2, 600, 100);
  font = loadFont("Arial-BoldMT-48.vlw");
  textFont(font);
  fill(255);
  textSize(80);
  textLeading(50);
  textAlign(CENTER, CENTER);
  text("EASY", width/2, height/2);
  
  // Creating the Medium box
  fill(#F2AA22);
  rect(width/2, height/2 + 150, 600, 100);
  fill(255);
  textSize(80);
  textLeading(50);
  textAlign(CENTER, CENTER);
  text("MEDIUM", width/2, height/2 + 150);
  
  // Creating the Hard box
  fill(#F22222);
  rect(width/2, height/2 + 300, 600, 100);
  fill(255);
  textSize(80);
  textLeading(50);
  textAlign(CENTER, CENTER);
  text("HARD", width/2, height/2 + 300);
 
}

// The purpose of the balloon method is to give the foundation for the game. The idea is that the balloons are instantiated from the Balloon Class as objects, with the parameters required, such as the 
// radius, the speed, the positions in the y-axis and the x-axis the alpha (transparency). Once the user loses however, this method will end, forcing the user to go back to the title screen.
void balloonMethod(){
   // Each time the draw function iterates, we have to make sure that the screen will reset afterwards.
  layer1.beginDraw();
  // The blue sky background is created here.
  background(59, 168, 255);
  // Using the rectMode "CORNERS", we create the "grass" of the animation.
  rectMode(CORNERS);
  // The color of the grass will obviously be a greenish tone.
  fill(#1AED49);
  // We set the grass close to the bottom of the screen.
  rect(0, height - 300, width, height);
  // Create the clouds of the program!
  image(cloudImage, -200, 120);
  image(cloudImage, width/2, 120);
  image(cloudImage, width/5, 150);
  image(cloudImage, width - 300, 150);
  
  // We end the draw for the background as we will be drawing other parts as well.
  layer1.endDraw();
  // This layer will be aligned to the left corner of the screen. These steps will not be repeated for the other layers.
  image(layer1, 0, 0);
  
  // The idea is that this process is similar to that found in the last coding assignment, where we instantiate in each index of the array, an array object.
  // The conditional is there to prevent a null pointer exception or out of bounds exception; if the index that we are currently in is 1 less than the array size,
  // then we can instanatiate a balloon object from the Balloon class. 
  if (ballCount < maxBalloons-1) {
    // We create a new Balloon object called oneBalloon, putting in place the xPosition, the yPosition, the speed, and the radius of the balloon in question.
    // The concept behind this is that there is no efficient way to delay the balloons from emerging from the bottom of the screen; previous testing has shown that.
    // What this means is that we have to physically declare the positions of the balloons way lower than the screen in which it is because the balloons
    // will be moving at a fast rate (given 30 pixels/second and the difficulty).
     Balloon oneBalloon = new Balloon(random(radius, width-radius), (height + random(100, 1000) * random(1, 3)), speed, radius, 255, 15);
     // Then, we assign the object to an index in the actual array itself.
     allBalloons[ballCount] = oneBalloon;
     // Increase the ball count by 1 each time that this conditional is run.
     ballCount++;
  }
  // If the counter is greater than what the array can genuinely hold, then we need to reset the counter variable in order for the program to continue running.
  if (ballCount >= maxBalloons){
      ballCount = 0;
  }
  
  // Set the basis for the balloons.
  // We iterate through all of the balloon objects in the array that was established to move all of the object balloons towards the top of the screen.
  layer2.beginDraw();
  for (int i = 0; i < ballCount; i++) {
      allBalloons[i].move(difficulty);
    // We then check whether the balloons have indeed reached the top yet based on whether they have been shot down yet (their transparency) as well as their position on the screen.
    if (allBalloons[i].returnYPos() <= radius/4 && allBalloons[i].returnAlpha() != 0){
      // Return back to the title screen
      onTitleScreen = true;
      // If they have, all of the balloons will be resetted to a different position, and their speeds will also be set to 0. As such, we will reset the screen.
      for (int i2 = 0; i < ballCount; i++){
        // The genius behind this is that the user will
         Balloon oneBalloon = new Balloon(random(radius, width-radius), (height + random(100, 1000) * (ballCount + 1)), 0, radius, 255, 15);
         allBalloons[i2] = oneBalloon;
      }
      // If the balloons are all resetted, then it means the player has probably led him/herself to the title screen, and we must stop iterating through the balloon array.
      ballCount = 0;
      score = 0;
     // The background has to be reset if the user fails.
     // The title screen will be displayed, and the scoreboard will disappear if the user fails the game.
     difficulty = " "; 
     // loseScreen = true;
    }
 }
 
 layer2.endDraw();
 // Align the second layer to the top left of the screen.
 image(layer2, 0, 0);
 
  // Set the basis for the scoreboard.
  layer3.beginDraw();
  // The scoreboard is set to full opacity (meaning that the user will see it completely and not just faded away).
  scoreBoard(255);
  layer3.endDraw();
  // Align the third layer to the top left corner of the screen.
  image(layer3, 0, 0);
}

// This will serve as the lose screen (if the user fails to keep going). 
void loseScreen(){
  background(59, 168, 255);
  fill(#F7A500);
  rect(width/2, height/3 + 300, 920, 320);
  // This is what would happen if you lose the game. You have a button that says, "return to the title screen".
  rect(width/2, height - 100, 830, 150);
  
  // The user would see that he or she has lost and that the score was the score that he or she has gained. If the person wants to keep going, he or she would be directed to the 
  fill(255);
  textSize(40);
  textAlign(LEFT, CENTER);
  text("Unfortunately, you have lost. Your score was " + score + ". If you want to\nplay again, please click the button below!", width/2 - 450, height/3 + 300);
  textSize(50);
  textLeading(30);
  textAlign(CENTER, CENTER);
  text("RETURN TO TITLE SCREEN", width/2, height-100);
  
}

// This will act to display the scoreboard of the user while he or she is actually playing. The parameter that is being passed is the transparency (if the user loses, then the scoreboard should not still be there).
void scoreBoard(float alpha){
   // We are going to create the score board for the user, which will mainly be displayed at the bottom of the screen
   // If we are allowed to display the score (such as if the user is playing a game still), then we will display the score.
   rectMode(CENTER);
   noStroke();
   fill(0, alpha);
   rect(width/2, height - 50, 600, 100);
   font = loadFont("Arial-BoldMT-48.vlw");
   textFont(font);
   fill(#FF8A0D, alpha);
   textSize(80);
   textLeading(50);
   textAlign(CENTER, CENTER);
   text("SCORE: " + score, width/2, height - 50);
}

// The tutorial is all about making sure that the user knows what he or she is doing once he clicks on Easy, Medium or Hard. Regardless of the difficulty, the user should be
// given the necessary instructions to play his or her preferred difficulty.
void tutorial(){
   // We must code the welcome sign and the main instructions for the game.
   background(59, 168, 255);
   rectMode(CENTER);
   stroke(255, 255);
   fill(#FF08AD);
   
   // These are all the rectangles that will act as the text boxes for each block of text. The main ones that will be shown is the "WELCOME",
   // the basic instructions for the game, and the "PLAY" button, respectively.
   rect(width/2, height/3, 800, 150);
   rect(width/2, height/3 + 300, 920, 320);
   fill(#0DDE23);
   rect(width/2, height - 100, 830, 150);
   
   // The main welcome sign is coded here, with a magenta box.
   fill(255);
   textSize(120);
   textLeading(30);
   textAlign(CENTER, CENTER);
   text("WELCOME!", width/2, height/3 - 5);
   
   // The instructions are placed here.
   textSize(40);
   textAlign(LEFT, CENTER);
   text("To play the game, you must shoot down\nthe balloons by left-clicking them as they come\nfrom the bottom of the screen. "
   + "If the balloons\nmanage to hit the top of the screen, you're out!\nEvery balloon shot adds 10 points to your score,\nbut if you hit the center, that will be 50 points!", width/2 - 450, height/3 + 300);
  
  // We then create the play text that will be encapsulated by the boxes that we've created above.
   textSize(90);
   textLeading(30);
   textAlign(CENTER, CENTER);
   text("PLAY", width/2, height-100);
}

// This will employ the easy method set out in the title screen
void easy() {
  // The speed of the balloon as it rises from the bottom to the top will be at 3 pixels to 5 pixels per second.
  speed = random(3, 5);
  // The balloon method will run the code intended for the easy() mode.
  balloonMethod();
}

// This will employ the medium method as set out in the title screen
void medium() {
  // The speed of the balloon as it rises from the bottom to the top will be at 5 pixels to 9 pixels per second.
  speed = random(5, 9);
  // The balloon method will run the code intended for the medium() mode.
  balloonMethod();
}

// This will employ the hard method as set out in the title screen
void hard() {
  // The speed of the balloon as it rises from the bottom to the top will be at 10 pixels to 14 pixels per second.
  speed = random(10, 14);
  // The balloon method will run the code intended for the medium() mode.
  balloonMethod();
}
