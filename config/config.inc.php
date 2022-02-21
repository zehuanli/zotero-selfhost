<?
class Z_CONFIG {
	public static $API_ENABLED = true;
	public static $READ_ONLY = false;
	public static $MAINTENANCE_MESSAGE = 'Server updates in progress. Please try again in a few minutes.';
	public static $BACKOFF = 0;

	public static $TESTING_SITE = false;
	public static $DEV_SITE = false;
	
	public static $DEBUG_LOG = false;
	
	public static $BASE_URI = 'http://localhost:8080';
	public static $API_BASE_URI = 'http://localhost:8080/';
	public static $WWW_BASE_URI = 'http://localhost:8080/';
	
	public static $API_SUPER_USERNAME = 'admin';
	public static $API_SUPER_PASSWORD = 'admin';
	
	public static $AWS_REGION;
	public static $AWS_ACCESS_KEY;
	public static $AWS_SECRET_KEY;
	public static $S3_BUCKET;
	public static $S3_BUCKET_CACHE;
	public static $S3_BUCKET_FULLTEXT;
	public static $SQS_QUEUE_URL;

	public static $SNS_ALERT_TOPIC = '';

	public static $MEMCACHED_ENABLED = false;
	public static $MEMCACHED_SERVERS = array(
		'memcached:11211:1'
	);
	
	public static $TRANSLATION_SERVERS = [
		"http://translation1.localdomain:1969"
	];
	
	public static $CITATION_SERVERS = array(
		"citeserver1.localdomain:8080", "citeserver2.localdomain:8080"
	);
	
	public static $ELASTICSEARCH_ENABLED = false;
	public static $SEARCH_HOSTS = [''];
	
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
		self::$S3_BUCKET = getenv('S3_BUCKET');
		self::$S3_BUCKET_FULLTEXT = getenv('S3_BUCKET_FULLTEXT');
		self::$SQS_QUEUE_URL = getenv('SQS_QUEUE_URL');
	}
}
Z_CONFIG::init();
?>
