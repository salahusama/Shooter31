abstract class Enemy extends GameObject
{
	PVector forward;
	float health;
	float theta;
	float speed;

	Ship target;

	Enemy(float x, float y, float speed, Ship target)
	{
		super(x, y);
		this.target = target;
		forward = new PVector(0, 0);
		this.speed = speed;

		updateTheta();
	}

	void updateTheta()
	{
		// theta = atan( opp/adj )
		// theta will point at target
		// will be good for firing
		float deltaX = target.pos.x - this.pos.x;
		float deltaY = target.pos.y - this.pos.y;
		theta = HALF_PI + atan2(deltaY, deltaX);
	}
}