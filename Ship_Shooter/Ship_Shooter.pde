import peasy.*;

PeasyCam cam;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;

ArrayList<GameObject> gameObjects;
ArrayList<Bullet> bullets;

Ship ship;
Background background;

void setup()
{
	fullScreen(P3D);


	gameObjects = new ArrayList<GameObject>();
	bullets = new ArrayList<Bullet>();

	ship = new Ship(width / 2, height / 2);
	gameObjects.add(ship);

	float xLimit1 = ship.pos.x - 1000;
	float xLimit2 = ship.pos.x + 1000;
	float yLimit1 = ship.pos.x - 1000;
	float yLimit2 = ship.pos.x + 1000;

	background = new Background(200, xLimit1, xLimit2, yLimit1, yLimit2);

	/*
	cam = new PeasyCam(this, 0);
	cam.setMinimumDistance(50);
	cam.setMinimumDistance(500);
	cam.setRollRotationMode();
	*/
}

void draw()
{
	background.render();
	
	//cam.lookAt(ship.pos.x, ship.pos.y, 0);
	/*
	if (ship.pos.x % (width / 4) == 0)
	{
		float xLimit1 = ship.pos.x - 1000;
		float xLimit2 = ship.pos.x + 1000;
		float yLimit1 = ship.pos.x - 1000;
		float yLimit2 = ship.pos.x + 1000;

		background = new Background(200, xLimit1, xLimit2, yLimit1, yLimit2);
	}
	*/

	for (GameObject o : gameObjects)
	{
		o.render();
		o.update();
	}

	for (Bullet b : bullets)
	{
		if (b.alive) {
			b.render();
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