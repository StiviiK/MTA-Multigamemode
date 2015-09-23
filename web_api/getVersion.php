<?php
include("github/github-api.php");
use Milo\Github;

// Search for an Git Hash
foreach($_GET as $index => $key) {
	preg_match('/\b([a-f0-9]{40})\b/', $index, $GIT_HASH, PREG_OFFSET_CAPTURE);
	$GIT_HASH = $GIT_HASH[0][0];
}

$api = new Github\Api;
if (isset($GIT_HASH)) {
	$response = $api->get('/repos/StiviiK/vMultigamemode/git/commits/'.$GIT_HASH);
	$commitData = $api->decode($response);
	
	echo(json_encode($commitData));
} else {
	$response = $api->get('/repos/stiviik/vmultigamemode/git/refs/heads/develop');
	$commitData = $api->decode($response);

	echo("[".json_encode($commitData->object->sha)."]");
}
?>