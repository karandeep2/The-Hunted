package 
{
	
	public class Missile extends Entity 
	{

		private var speed = 3;

		public function Missile(tmpX : int, tmpY : int, tmpR : int) 
		{
			// constructor code
			x = tmpX;
			y = tmpY;
			rotation = tmpR;
		}
		
		override public function update()
		{
			var angle :Number = rotation * Math.PI / 180;
			x += speed * Math.sin(angle);
			y += speed * -Math.cos(angle);
		}

	}
	
}
