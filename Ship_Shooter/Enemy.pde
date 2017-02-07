class Enemy extends GameObject
{
	PVector forward;
	float health;

	Enemy(float x, float y)
	{
		super(x, y);
		forward = new PVector(0, 0);
	}
}