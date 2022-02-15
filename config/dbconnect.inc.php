<?
function Zotero_dbConnectAuth($db) {
	$charset = '';
	
	$host = getenv('DB_HOST');
	$port = 3306;
	$user = getenv('DB_USER');
	$pass = getenv('DB_PASS');

	if ($db == 'master') {
		$db = 'zotero_master';
		$state = 'up'; // 'up', 'readonly', 'down'
	}
	else if ($db == 'shard') {
		$db = 'zotero_shard_1';
	}
	else if ($db == 'id1') {
		$db = 'zotero_ids';
	}
	else if ($db == 'id2') {
		$db = 'zotero_ids';
	}
	else if ($db == 'www1') {
		$db = 'zotero_www';
	}
	else if ($db == 'www2') {
		$db = 'zotero_www';
	}
	else {
		throw new Exception("Invalid db '$db'");
	}
	return [
		'host' => $host,
		'replicas' => !empty($replicas) ? $replicas : [],
		'port' => $port,
		'db' => $db,
		'user' => $user,
		'pass' => $pass,
		'charset' => $charset,
		'state' => !empty($state) ? $state : 'up'
	];
}
?>
