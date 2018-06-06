// PARTICLE SWARM OPTIMIZATION
// Scott Ammon, 2014

// Global parameters here, change as desired
int   population_size = 750;
int   dimensions = 3;
int   sizeX = 1000;
int   sizeY = 1000;
float w  = 1.0; // default 1.0
float K  = 0.5; // default 0.5
float c1 = 2.1; // default 1.5
float c2 = 2.1; // default 1.5
int counter = 0;

// Create screen, enable 3D plotting
void setup() 
{
  size(1000,1000,P3D);
  background(0);
  frameRate(1);
}

// Declare object outside of draw function
popObject Swarm = new popObject(-5,5,-1,1);
  
// Processing will automatically loop this function until user intervention
void draw()
{
    background(255);
    Swarm.runPSO();
   
    for(int i = 0; i < population_size; i++)
    {
      pushMatrix();
      noStroke();
      lights();
      translate(Swarm.popArray[i][0]*75 + sizeX/2, Swarm.popArray[i][1]*75 + sizeY/2, Swarm.popArray[i][2]*75);
      fill(53,119,206);
      sphere(10);
      popMatrix();
      
    }
    w = w * K; // Inertial Decrement - can put this into Class if desired
    
    // add camera functionality later
    //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
    
    print("Global Best is:   ");
    println(Swarm.G_best[0][0], "    ", Swarm.G_best[0][1], "    ", Swarm.G_best[0][2]);
    
    // Use no loop to capture a single shot
    // noLoop();
}

class popObject
{
  float[][] popArray    = new float[population_size][dimensions];
  float[][] popVelocity = new float[population_size][dimensions];
  float[][] popBest     = new float[population_size][dimensions];
  
  float[] popArrayFit = new float[population_size];
  float[] popBestFit  = new float[population_size];

  float[][] G_best      = new float[1][dimensions];
  float Gfit;
  
  float[] old_fitness = new float[population_size];
  float[] new_fitness = new float[population_size];
  
  float[][] r = new float[dimensions][dimensions];
  int minVal;
  int maxVal;
  int minVelocity;
  int maxVelocity;
  
  // Constructor for popObject
  popObject(int minValue, int maxValue, int minVeloc, int maxVeloc)
  {
    minVal = minValue;
    maxVal = maxValue;
    minVelocity = minVeloc;
    maxVelocity = maxVeloc;
    
    // initialize the popArray with random values
    for (int a = 0; a < population_size; a++)
    {
      for(int b = 0; b < dimensions; b++)
      {
        popArray[a][b] = random(minVal,maxVal);
      }
    }
    
    // initialize the popBest array with popArray values
    popBest = popArray;
 
    // initialize the popVelocity array with random values
    for (int a = 0; a < population_size; a++)
    {
      for(int b = 0; b < dimensions; b++)
      {
        popVelocity[a][b] = random(minVelocity,maxVelocity);
      }
    } 
  } 
  // End Constructor Here //
  
  // Runs 1 iteration of the particle swarm optimization. Call this function for as many iterations as you want
  void runPSO()
  {
    // This needs to change based on the fitness formula being used (e.g. z = x^2 + y^2)
    for (int i = 0; i < population_size; i++)
    {
      popArrayFit[i] = popArray[i][0]*popArray[i][0]+popArray[i][1]*popArray[i][1] + popArray[i][2]*popArray[i][2];
      popBestFit[i] = popBest[i][0]*popBest[i][0]+popBest[i][1]*popBest[i][1] + popBest[i][2]*popBest[i][2];
    }
    
    // Update G_best with the minimum value of popBest
    float tempMin  = popBestFit[0];
    int position = 0; 
    for (int i = 0; i < population_size; i++)
    { 
      if (popBestFit[i] < tempMin)
      {
         position = i;
         tempMin = popBestFit[i];
      }
    } 
    for (int x = 0; x < dimensions; x++)
    {
      G_best[0][x] = popBest[position][x];
    }
  
    // Compute the fitness of the global best variables. Also needs to change with whatever fitness formula you are using.
    Gfit = G_best[0][0]*G_best[0][0] + G_best[0][1]*G_best[0][1]+ G_best[0][2]*G_best[0][2];
    
    // After computing the fitness arrays, update the population best and global best arrays
    for (int i = 0; i < population_size; i++)
     {
       if (popArrayFit[i] < popBestFit[i])
       {
          for(int j = 0; j < dimensions; j++)
          {
            popBest[i][j] = popArray[i][j]; 
          }          
       }
       
       if (popArrayFit[i] < Gfit)  // Popbestfit could be used here
       {
         for(int j = 0; j < dimensions; j++)
         {
           G_best[0][j] = popArray[i][j];
         }
       }
     }
    // POSITION UPDATE
    // Uses Particle Swarm Optimization function to update population array with all new positions
    for (int i = 0; i < population_size; i++)
    {
    // CREATE RANDOM VARIABLE MATRIX
      for (int a = 0; a < dimensions; a++)
      {
        for(int b = 0; b < dimensions; b++)
        {
          r[a][b] = random(0,1);
        }
      }
      for (int j = 0; j < dimensions; j++)  
      { 
        popVelocity[i][j] = w*popVelocity[i][j] + c1*r[j][0]*(popBest[i][j] - popArray[i][j]) + c2*r[j][1]*(G_best[0][j] - popArray[i][j]);
      }
      // REVISE POPULATION BY ADDING VELOCITY TO CURRENT VALUES
      for(int x = 0; x < dimensions; x++)
      {
        popArray[i][x] = popArray[i][x] + popVelocity[i][x]; 
      }
    }
  }
}
