class Enemy extends GameObject
{
	PVector forward;
	float health;
	float theta;

	Ship target;

	Enemy(float x, float y, Ship target)
	{
		super(x, y);
		this.target = target;
		forward = new PVector(0, 0);

		this.theta = getTheta();
	}

	float getTheta()
	{
		// theta = atan( opp/adj )
		// theta will point at target
		// will be good for firing
		float deltaX = target.pos.x - this.pos.x;
		float deltaY = target.pos.y - this.pos.y;

		return atan( radians(deltaX / deltaY) );

	}
}