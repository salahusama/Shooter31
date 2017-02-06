class GameObject
{
	PVector pos;

	GameObject(float x, float y)
	{
		pos = new PVector(x, y);
	}

	void render()
	{
		fill(255);
		ellipse(pos.x, pos.y, 10, 10);
	}
}