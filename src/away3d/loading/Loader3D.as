package away3d.loading
{
	import away3d.containers.ObjectContainer3D;
	import away3d.entities.Mesh;
	import away3d.events.AssetEvent;
	import away3d.events.LoadingEvent;
	import away3d.events.LoadingEvent;
	import away3d.loading.assets.AssetType;
	import away3d.loading.misc.AssetLoaderContext;
	import away3d.loading.misc.SingleResourceLoader;
	import away3d.loading.parsers.ParserBase;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	public class Loader3D extends ObjectContainer3D
	{
		private var _useAssetLib : Boolean;
		private var _assetLibId : String;
		
		public function Loader3D(useAssetLibrary : Boolean = true, assetLibraryId : String = null)
		{
			super();
			
			_useAssetLib = useAssetLibrary;
			_assetLibId = assetLibraryId;
		}
		
		
		public function load(req : URLRequest, parser : ParserBase = null, context : AssetLoaderContext = null, namespace : String = null) : void
		{
			if (_useAssetLib) {
				var lib : AssetLibrary;
				
				lib = AssetLibrary.getInstance(_assetLibId);
				lib.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetRetrieved);
				lib.addEventListener(away3d.events.LoadingEvent.RESOURCE_COMPLETE, onResourceRetrieved);
				lib.load(req, parser, context, namespace);
			}
			else {
				var loader : AssetLoader = new AssetLoader();
				loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetRetrieved);
				loader.addEventListener(away3d.events.LoadingEvent.RESOURCE_COMPLETE, onResourceRetrieved);
				loader.load(req, parser, context, namespace);
			}
		}
		
		
		public function parseData(data : *, parser : ParserBase = null, context : AssetLoaderContext = null,  namespace : String = null) : void
		{
			if (_useAssetLib) {
				var lib : AssetLibrary;
				
				lib = AssetLibrary.getInstance(_assetLibId);
				lib.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetRetrieved);
				lib.addEventListener(away3d.events.LoadingEvent.RESOURCE_COMPLETE, onResourceRetrieved);
				lib.parseData(data, parser, context, namespace);
			}
			else {
				var loader : AssetLoader = new AssetLoader();
				loader.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetRetrieved);
				loader.addEventListener(LoadingEvent.DATA_LOADED, onResourceRetrieved);
				loader.parseData(data, '', parser, context, namespace);
			}
		}
		
		
		public static function enableParser(parserClass : Class) : void
		{
			SingleResourceLoader.enableParser(parserClass);
		}
		
		
		public static function enableParsers(parserClasses : Vector.<Class>) : void
		{
			SingleResourceLoader.enableParsers(parserClasses);
		}
		
		
		
		private function onAssetRetrieved(ev : AssetEvent) : void
		{
			var type : String = ev.asset.assetType;
			if (type == AssetType.CONTAINER) {
				this.addChild(ObjectContainer3D(ev.asset));
			}
			else if (type == AssetType.MESH) {
				var mesh : Mesh = Mesh(ev.asset);
				if (mesh.parent == null)
					this.addChild(mesh);
			}
			
			this.dispatchEvent(ev.clone());
		}
		
		
		private function onResourceRetrieved(ev : Event) : void
		{
			var dispatcher : EventDispatcher;
			
			dispatcher = EventDispatcher(ev.currentTarget);
			dispatcher.removeEventListener(AssetEvent.ASSET_COMPLETE, onAssetRetrieved);
			dispatcher.removeEventListener(away3d.events.LoadingEvent.RESOURCE_COMPLETE, onResourceRetrieved);
			dispatcher.removeEventListener(LoadingEvent.DATA_LOADED, onResourceRetrieved);
			
			this.dispatchEvent(ev.clone());
		}
	}
}