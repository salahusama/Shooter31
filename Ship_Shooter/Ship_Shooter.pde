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
	background = new Background(200);

	//cam = new PeasyCam(this.ship, 0);
	//cam.setMinimumDistance(50);
	//cam.setMinimumDistance(500);

	//cam.setRollRotationMode();
}

void draw()
{
	background.render();
	
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