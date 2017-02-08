import ddf.minim.*;
import peasy.*;

PeasyCam cam;
Minim minim;

AudioPlayer hit;
AudioPlayer normalShot;
AudioPlayer loudShot;
AudioPlayer death;

PFont font;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;
int state;
int difficulty = 1; // spawn rate
float lastSpawned = 0;
int score = 0;
int highScore = 0;

Background background;

ArrayList<GameObject> enemies;

ArrayList<Bullet> shipBullets;
ArrayList<Bullet> enemyBullets;

Ship ship;
float enemyNo = 5;

void setup()
{
	fullScreen(P3D);
	smooth(4);
	state = 1;
	enemies = new ArrayList<GameObject>();
	shipBullets = new ArrayList<Bullet>();
	enemyBullets = new ArrayList<Bullet>();

	font = loadFont("BodoniMTCondensed-Bold-200.vlw");
	textFont(font);
	ship = new Ship(width / 2, height / 2, 100);

	for (int i = 0; i < enemyNo; ++i)
	{
		float x1 = ship.pos.x - width / 2;
		float x2 = ship.pos.x + width / 2;
		float y1 = ship.pos.y - height / 2;
		float y2 = ship.pos.y + height / 2;
		float size = random(30, 100);

		if ( random(0, 100) < 50 ) {
			enemies.add( new BasicEnemy(x1, random(height), 1, size, 100, ship) );
		}
		else {
			enemies.add( new BasicEnemy(random(width), y1, 1, size, 100, ship) );
		}
	}

	float xLimit1 = ship.pos.x - 1000;
	float xLimit2 = ship.pos.x + 1000;
	float yLimit1 = ship.pos.x - 1000;
	float yLimit2 = ship.pos.x + 1000;

	background = new Background(200, xLimit1, xLimit2, yLimit1, yLimit2);
	
	minim = new Minim(this);
	hit = minim.loadFile("thud1.mp3");
	normalShot = minim.loadFile("shot1.mp3");
	loudShot = minim.loadFile("shot2.mp3");
	death = minim.loadFile("death.mp3");

	cam = new PeasyCam(this, (double)ship.pos.x, (double)ship.pos.y, 0, 0);
	cam.setMinimumDistance(50);
	cam.setMinimumDistance(500);
	cam.setRollRotationMode();
}

void draw()
{
	cam.lookAt((double)ship.pos.x, (double)ship.pos.y, 300, 0);

	background.render();

	// render ship
	//
	ship.render();
	ship.update();
	
	if ( ship.health <= 0 ) {
		gameOver();
	}

	switch (state)
	{
		case 0: {
			break;
		}
		case 1: {
			// render enemies
			//
			for (int i = 0; i < enemies.size(); i++)
			{
				GameObject e = enemies.get(i);

				e.render();
				e.update();

				fill(0);
				textSize(20);
				textAlign(CENTER, CENTER);
				text((int) e.health, e.pos.x, e.pos.y);
				
				if (e.health <= 0) {
					enemies.remove(i);
				}
				for (int j = 0; j < shipBullets.size(); j++)
				{
					Bullet b = shipBullets.get(j);
					if ( e.checkHit(b) )
					{
						shipBullets.remove(j);
						e.shake();
						e.health -= b.strength;
						score += b.strength;
					}
				}
			}

			// render ship bullets
			//
			for (int i = 0; i < shipBullets.size(); ++i)
			{
				Bullet b = shipBullets.get(i);
				if (b.alive) {
					b.render();
				}
				else {
					shipBullets.remove(i);
				}
			}

			// render enemy bullets
			//
			for (int i = 0; i < enemyBullets.size(); ++i)
			{
				Bullet b = enemyBullets.get(i);
				if (b.alive) {
					b.render();
				}
				else {
					enemyBullets.remove(i);
				}
			}
			
			// check hits from enemy collisions
			//
			for (int j = 0; j < enemyBullets.size(); j++)
			{
				Bullet b = enemyBullets.get(j);
				if ( ship.checkHit(b) )
				{
					enemyBullets.remove(j);
					ship.shake();
					ship.health -= b.strength;
				}
			}

			if ( gameTime - lastSpawned >= difficulty)
			{
				float x1 = ship.pos.x - width / 2;
				float x2 = ship.pos.x + width / 2;
				float y1 = ship.pos.y - height / 2;
				float y2 = ship.pos.y + height / 2;
				float size = random(30, 100);

				if ( random(0, 100) < 50 ) {
					enemies.add( new BasicEnemy(x1, random(height), 1, size, 100, ship) );
				}
				else {
					enemies.add( new BasicEnemy(random(width), y1, 1, size, 100, ship) );
				}
				lastSpawned = gameTime;
			}

			gameTime += timeDelta;
			break;
		}
	}
	displayScore();
}

void gameOver()
{
	death.play();
	fill(255, 50, 50);
	textSize(250);
	textAlign(CENTER, CENTER);
	text("GAME OVER", ship.pos.x, ship.pos.y);

	// high score
	if (score > highScore) {
		highScore = score;
	}
	fill(50, 200, 100);
	textSize(50);
	textAlign(CENTER, CENTER);
	text("High Score: " + highScore, ship.pos.x, ship.pos.y - 250);

	state = 0;

	// remove all enemies
	for (int i = 0; i < enemies.size(); ++i)
	{
		enemies.remove(i);
	}

	// remove all enemyBullets
	for (int i = 0; i < enemyBullets.size(); ++i)
	{
		enemyBullets.remove(i);
	}

	// remove all shipBullets
	for (int i = 0; i < shipBullets.size(); ++i)
	{
		shipBullets.remove(i);
	}

	fill(255);
	textSize(70);
	textAlign(CENTER, CENTER);
	text("Press 'R' to Continue", ship.pos.x, ship.pos.y + width / 4);
}

void reset()
{
	state = 1;
	score = 0;
	ship.health = 100;
	death.rewind();
}

void displayScore()
{
	fill(0, 255, 255);
	textSize(60);
	textAlign(CENTER, CENTER);
	text("Score: " + score, ship.pos.x, ship.pos.y + 30 - height / 2);
}

boolean[] keys = new boolean[1000];

void keyPressed()
{ 
	keys[keyCode] = true;
}
 
void keyReleased()
{
	if ( key == 'r' || key == 'R') {
		reset();
	}
	keys[keyCode] = false; 
}

boolean checkKey(int k)
{
	if (keys.length >= k) {
		return keys[k] || keys[Character.toUpperCase(k)];  
	}
	return false;
}