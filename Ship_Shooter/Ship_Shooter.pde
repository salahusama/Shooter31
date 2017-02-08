import ddf.minim.*;
import peasy.*;

PeasyCam cam;
Minim minim;

AudioPlayer hit;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;
int state;

Background background;

ArrayList<GameObject> gameObjects;
ArrayList<Bullet> bullets;

Ship ship;
float enemyNo = 5;

void setup()
{
	fullScreen(P3D);

	state = 1;
	gameObjects = new ArrayList<GameObject>();
	bullets = new ArrayList<Bullet>();

	ship = new Ship(width / 2, height / 2, 1000);
	gameObjects.add(ship);

	for (int i = 0; i < enemyNo; ++i)
	{
		float x1 = ship.pos.x - width / 2;
		float x2 = ship.pos.x + width / 2;
		float y1 = ship.pos.y - height / 2;
		float y2 = ship.pos.y + height / 2;
		
		if ( random(0, 100) < 50 ) {
			gameObjects.add( new BasicEnemy(x1, random(height), 1.0, 15.0, ship) );
		}
		else {
			gameObjects.add( new BasicEnemy(random(width), y1, 1, 15, ship) );
		}
	}

	float xLimit1 = ship.pos.x - 1000;
	float xLimit2 = ship.pos.x + 1000;
	float yLimit1 = ship.pos.x - 1000;
	float yLimit2 = ship.pos.x + 1000;

	background = new Background(200, xLimit1, xLimit2, yLimit1, yLimit2);
	
	minim = new Minim(this);
	hit = minim.loadFile("thud1.mp3");

	cam = new PeasyCam(this, (double)ship.pos.x, (double)ship.pos.y, 0, 0);
	cam.setMinimumDistance(50);
	cam.setMinimumDistance(500);
	cam.setRollRotationMode();
}

void draw()
{
	cam.lookAt((double)ship.pos.x, (double)ship.pos.y, 300, 0);

	background.render();
	for (int i = 0; i < gameObjects.size(); i++)
	{
		GameObject o = gameObjects.get(i);

		o.render();
		o.update();
		
		if (o.health < 0) {
			gameObjects.remove(i);
		}
		for (int j = 0; j < bullets.size(); j++)
		{
			Bullet b = bullets.get(j);
			if ( o.checkHit(b) )
			{
				bullets.remove(j);
				o.shake();
				o.health -= b.strength;
			}
		}
	}

	for (int i = 0; i < bullets.size(); ++i)
	{
		Bullet b = bullets.get(i);
		if (b.alive) {
			b.render();
		}
		else {
			bullets.remove(i);
		}
	}
	
	gameTime += timeDelta;
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