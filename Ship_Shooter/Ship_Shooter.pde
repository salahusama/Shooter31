import peasy.*;

PeasyCam cam;

float gameTime = 0.0;
float timeDelta = 1.0 / 60;
int state;

Background background;

ArrayList<GameObject> gameObjects;
ArrayList<Bullet> bullets;

Ship ship;
BasicEnemy tempEnemy;

void setup()
{
	fullScreen(P3D);

	state = 1;
	gameObjects = new ArrayList<GameObject>();
	bullets = new ArrayList<Bullet>();

	ship = new Ship(width / 2, height / 2, 100);
	gameObjects.add(ship);

	tempEnemy = new BasicEnemy(100, 100, 2, ship, 100);
	gameObjects.add(tempEnemy);

	float xLimit1 = ship.pos.x - 1000;
	float xLimit2 = ship.pos.x + 1000;
	float yLimit1 = ship.pos.x - 1000;
	float yLimit2 = ship.pos.x + 1000;

	background = new Background(200, xLimit1, xLimit2, yLimit1, yLimit2);

	cam = new PeasyCam(this, 0);
	cam.setMinimumDistance(50);
	cam.setMinimumDistance(500);
	cam.setRollRotationMode();
}

void draw()
{
	//cam.lookAt((double)ship.pos.x, (double)ship.pos.y, 0);

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