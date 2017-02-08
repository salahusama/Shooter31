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
		PVector shake = new PVector(random(-20, 20), random(-20, 20));
		pos.add(shake);
	}

	boolean checkHit(Bullet b)
	{
		float distance = dist(b.pos.x, b.pos.y, this.pos.x, this.pos.y);

		if ( distance <= b.strength / 2 || distance <= this.oWidth / 2)
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