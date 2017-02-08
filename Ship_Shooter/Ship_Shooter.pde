import ddf.minim.*;
import peasy.*;

PeasyCam cam;
Minim minim;

AudioPlayer hit;
AudioPlayer normalShot;
AudioPlayer loudShot;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;
int state;
int difficulty = 10; // spawn rate
float lastSpawned = 0;
int score;

Background background;

ArrayList<GameObject> enemies;

ArrayList<Bullet> shipBullets;
ArrayList<Bullet> enemyBullets;

Ship ship;
float enemyNo = 5;

void setup()
{
	fullScreen(P3D);

	state = 1;
	enemies = new ArrayList<GameObject>();
	shipBullets = new ArrayList<Bullet>();
	enemyBullets = new ArrayList<Bullet>();

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

	cam = new PeasyCam(this, (double)ship.pos.x, (double)ship.pos.y, 0, 0);
	cam.setMinimumDistance(50);
	cam.setMinimumDistance(500);
	cam.setRollRotationMode();
}

void draw()
{
	cam.lookAt((double)ship.pos.x, (double)ship.pos.y, 300, 0);

	background.render();

	if ( ship.health >= 0 )
	{
		ship.render();
		ship.update();
	}
	else
	{
		gameOver();
	}


	// render enemies
	//
	for (int i = 0; i < enemies.size(); i++)
	{
		GameObject e = enemies.get(i);

		e.render();
		e.update();

		fill(0);
		textSize(10);
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
	
	// check collisions
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
}

void gameOver()
{
	fill(255, 50, 50);
	textSize(100);
	textAlign(CENTER, CENTER);
	text("GAME OVER", ship.pos.x, ship.pos.y);

	state = 0;
}

boolean[] keys = new boolean[1000];

void keyPressed()
{ 
	keys[keyCode] = true;
}
 
void keyReleased()
{
	keys[keyCode] = false; 
}

boolean checkKey(int k)
{
	if (keys.length >= k) {
		return keys[k] || keys[Character.toUpperCase(k)];  
	}
	return false;
}