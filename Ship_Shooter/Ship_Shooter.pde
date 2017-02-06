float timeDelta = 1.0/60;

ArrayList<GameObject> GameObjects;
Ship ship;

void setup()
{
	fullScreen();
	ship = new Ship(width / 2, height / 2);
	GameObjects.add(ship);
}

void draw()
{
	/*
	background.render();
	for (GameObject o : GameObjects)
	{
		o.render();
		o.update();
	}
	*/
	background(0);
	ship.render();
	ship.update();
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