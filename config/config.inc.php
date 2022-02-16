<?
class Z_CONFIG {
	public static $API_ENABLED = true;
	public static $READ_ONLY = false;
	public static $MAINTENANCE_MESSAGE = 'Server updates in progress. Please try again in a few minutes.';
	public static $BACKOFF = 0;

	public static $TESTING_SITE = false;
	public static $DEV_SITE = false;
	
	public static $DEBUG_LOG = true;
	
	public static $BASE_URI = 'http://localhost:8080';
	public static $API_BASE_URI = 'http://localhost:8080/';
	public static $WWW_BASE_URI = 'http://localhost:8080/';
	
	public static $AUTH_SALT = 'dhAyudsHU176dsqhUY';
	public static $API_SUPER_USERNAME = 'admin';
	public static $API_SUPER_PASSWORD = 'admin';
	
	public static $AWS_REGION;
	public static $AWS_ACCESS_KEY;
	public static $AWS_SECRET_KEY;
	public static $S3_BUCKET;
	public static $S3_ENDPOINT;
	public static $S3_BUCKET_CACHE;
	public static $S3_BUCKET_FULLTEXT;
	public static $SNS_ALERT_TOPIC = '';

	public static $REDIS_HOSTS = [
		'default' => [
			'host' => 'redis'
		],
		'request-limiter' => [
			'host' => 'redis'
		],
		'notifications' => [
			'host' => 'redis'
		],
		'fulltext-migration' => [
			'host' => 'redis',
			'cluster' => false
		]
	];

	public static $REDIS_PREFIX = '';
	
	public static $MEMCACHED_ENABLED = true;
	public static $MEMCACHED_SERVERS = array(
		'memcached:11211:1'
	);
	
	public static $TRANSLATION_SERVERS = [
		"http://translation1.localdomain:1969"
	];
	
	public static $CITATION_SERVERS = array(
		"citeserver1.localdomain:8080", "citeserver2.localdomain:8080"
	);
	
	public static $SEARCH_HOSTS = ['elasticsearch'];
	
	public static $GLOBAL_ITEMS_URL = '';
	
	public static $ATTACHMENT_PROXY_URL = "https://files.example.com/";
	public static $ATTACHMENT_PROXY_SECRET = "";
	
	public static $STATSD_ENABLED = false;
	public static $STATSD_PREFIX = "";
	public static $STATSD_HOST = "monitor.localdomain";
	public static $STATSD_PORT = 8125;
	
	public static $LOG_TO_SCRIBE = false;
	public static $LOG_ADDRESS = '';
	public static $LOG_PORT = 1463;
	public static $LOG_TIMEZONE = 'US/Eastern';
	public static $LOG_TARGET_DEFAULT = 'errors';
	
	public static $HTMLCLEAN_SERVER_URL = 'http://localhost:16342';
	
	// Set some things manually for running via command line
	public static $CLI_PHP_PATH = '/usr/bin/php';
	
	public static $ERROR_PATH = '/var/log/zotero/';
	
	public static $CACHE_VERSION_ATOM_ENTRY = 1;
	public static $CACHE_VERSION_BIB = 1;
	public static $CACHE_VERSION_ITEM_DATA = 1;
	public static $CACHE_VERSION_RESPONSE_JSON_COLLECTION = 1;
	public static $CACHE_VERSION_RESPONSE_JSON_ITEM = 1;

	static function init() {
		self::$AWS_REGION = getenv('AWS_REGION');
		self::$AWS_ACCESS_KEY = getenv('AWS_ACCESS_KEY_ID');
		self::$AWS_SECRET_KEY = getenv('AWS_SECRET_ACCESS_KEY');
		self::$S3_BUCKET = getenv('S3_BUCKET');
		self::$S3_ENDPOINT = getenv('S3_ENDPOINT');
		self::$S3_BUCKET_CACHE = getenv('S3_BUCKET_CACHE');
		self::$S3_BUCKET_FULLTEXT = getenv('S3_BUCKET_FULLTEXT');
	}
}
Z_CONFIG::init();
?>
