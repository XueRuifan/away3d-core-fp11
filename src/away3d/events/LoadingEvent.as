﻿package away3d.events{	import flash.events.Event;		/**	 * LoaderEvent is an Event dispatched to notify changes in loading state.	 */	public class LoadingEvent extends Event	{		/**		 * Dispatched when loading of an asset completed.		 */		public static const DATA_LOADED : String = "dataLoaded";				/**		 * Dispatched when parsing of an asset completed.		 */		public static const DATA_PARSED : String = "dataParsed";				/**		 * TODO: document		*/		public static const DATA_ERROR : String = 'dataError';				/**		 * Dispatched when loading of a asset failed.		 */		public static const LOAD_ERROR : String = "loadError";				/**		 * Dispatched when loading of a bitmap (png. jpg) failed.		 */		public static const LOAD_MAP_ERROR : String = "loadMapError";				/**		 * Dispatched when a resource and all of its dependencies is retrieved.		 */		public static const RESOURCE_COMPLETE : String = "resourceComplete";				/**		 * Dispatched when a resource's dependency is retrieved and resolved.		 */		public static const DEPENDENCY_COMPLETE : String = "dependencyComplete";						/**		 * Dispatched when a resource's dependency error occurs.		 * Such as wrong parser type, unsupported extensions, parsing errors, malformated or unsupported 3d file etc..		 */		public static const DEPENDENCY_ERROR : String = "dependencyError";								private var _url : String;		private var _message : String;				/**		 * Create a new LoaderEvent object.		 * @param type The event type.		 * @param resource The loaded or parsed resource.		 * @param url The url of the loaded resource.		 */		public function LoadingEvent(type:String, url : String = null, errmsg : String = null)		{			super(type);			_url = url;			_message = errmsg;		}				/**		 * The url of the loaded resource.		 */		public function get url() : String		{			return _url;		}				/**		 * The error string on loadError.		 */		public function get message() : String		{			return _message;		}								/**		 * Clones the current event.		 * @return An exact duplicate of the current event.		 */		public override function clone() : Event		{			return new LoadingEvent(type, _url, _message);		}			}}