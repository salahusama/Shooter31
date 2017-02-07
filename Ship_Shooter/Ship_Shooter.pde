import peasy.*;

PeasyCam cam;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;
Background background;

ArrayList<GameObject> gameObjects;
ArrayList<Bullet> bullets;

Ship ship;
BasicEnemy tempEnemy;

void setup()
{
	fullScreen(P3D);


	gameObjects = new ArrayList<GameObject>();
	bullets = new ArrayList<Bullet>();

	ship = new Ship(width / 2, height / 2);
	gameObjects.add(ship);

	tempEnemy = new BasicEnemy(100, 100, 2, ship, 100);
	gameObjects.add(tempEnemy);

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

	for (GameObject o : gameObjects)
	{
		o.render();
		o.update();
	}
	/* Other for loop allows us to remove bullets after they die
	for (Bullet b : bullets)
	{
		if (b.alive) {
			b.render();
		}
	}*/

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