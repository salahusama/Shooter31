abstract class GameObject
{
	PVector pos;
	float health;
	float oWidth;
	float oHeight;

	GameObject(float x, float y, float health)
	{
		pos = new PVector(x, y);
		this.health = health;
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

	boolean checkHit(Bullet b)
	{
		float xLimit1 = b.pos.x - b.strength / 2;
		float xLimit2 = b.pos.x + b.strength / 2;

		float yLimit1 = b.pos.y - b.strength / 2;
		float yLimit2 = b.pos.y + b.strength / 2;

		if (xLimit1 > this.pos.x - oWidth/2 && xLimit2 < this.pos.x + oWidth/2 && yLimit1 > this.pos.y - oHeight/2 && yLimit2 < this.pos.y + oHeight/2)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}