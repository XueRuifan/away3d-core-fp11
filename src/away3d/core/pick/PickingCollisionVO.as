package away3d.core.pick
{
	import away3d.entities.*;
	
	import flash.geom.*;
	
	/**
	 * Value object for a picking collision returned by a picking collider. Created as unique objects on entities
	 * 
	 * @see away3d.entities.Entity#pickingCollisionVO
	 * @see away3d.core.pick.IPickingCollider
	 */
	public class PickingCollisionVO
	{
		private var _entity:Entity;
		
		/**
		 * The local position of the collision on the entity's surface.
		 */
		public var localPosition:Vector3D;
		
		/**
		 * The local normal vector at the position of the collision.
		 */
		public var localNormal:Vector3D;
		
		/**
		 * The uv coordinate at the position of the collision.
		 */
		public var uv:Point;
		
		/**
		 * The starting position of the colliding ray in local coordinates.
		 */
		public var localRayPosition:Vector3D;
		
		/**
		 * The direction of the colliding ray in local coordinates.
		 */		
		public var localRayDirection:Vector3D;
		
		/**
		 * Determines if the ray position is contained within the entity bounds.
		 * 
		 * @see away3d.entities.Entity#bounds
		 */
		public var rayOriginIsInsideBounds:Boolean;
		
		/**
		 * The distance along the ray from the starting position to the calculated intersection best point with the entity.
		 */
		public var collisionT:Number;

		/**
		 * The distance along the ray from the starting position to the calculated intersection entry point with the entity.
		 */
		public var collisionNearT:Number;

		/**
		 * The distance along the ray from the starting position to the calculated intersection exit point with the entity.
		 */
		public var collisionFarT:Number;
		
		/**
		 * The entity to which this collision object belongs.
		 */
		public function get entity():Entity
		{
			return _entity;
		}
		
		/**
		 * Creates a new <code>PickingCollisionVO</code> object.
		 * 
		 * @param entity The entity to which this collision object belongs.
		 */
		function PickingCollisionVO(entity:Entity)
		{
			_entity = entity;
		}
	}
}
