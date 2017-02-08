abstract class GameObject
{
	PVector pos;
	float health;
	float oWidth;
	float oHeight;
	float lastHit;
	float timeToShake;
	boolean doShake;

	GameObject(float x, float y, float health)
	{
		pos = new PVector(x, y);
		this.health = health;
		lastHit = -1;
		doShake = false;
		timeToShake = 2;
	}

	void render()
	{
		fill(255);
		ellipse(pos.x, pos.y, 10, 10);
	}

	void update()
	{
		// k
	}

	void shake()
	{
		PVector shake = new PVector(random(-10, 10), random(-10, 10));
		pos.add(shake);
	}

	boolean checkHit(Bullet b)
	{
		float xLimit1 = b.pos.x - b.strength / 2;
		float xLimit2 = b.pos.x + b.strength / 2;

		float yLimit1 = b.pos.y - b.strength / 2;
		float yLimit2 = b.pos.y + b.strength / 2;

		if (xLimit1 > this.pos.x - oWidth/2 && xLimit2 < this.pos.x + oWidth/2 && yLimit1 > this.pos.y - oHeight/2 && yLimit2 < this.pos.y + oHeight/2)
		{
			lastHit = gameTime;
			hit.rewind();
			hit.play();
			return true;
		}
		else
		{
			return false;
		}
	}
}