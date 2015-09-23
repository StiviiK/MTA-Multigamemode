<?php
	require("api_storage/init.php");

	// Check for the requested method
	if(!isset($_GET["method"]) or $_GET["method"] == "") {
		$return["message"] = "No method given!";

		echo json_encode($return);
		return;
	}

	// Set data
	$file = "api_storage/{$_GET["method"]}.php";
	$return["method"] = $_GET["method"];

	// Check for Security token
	if(($noToken[$_GET["method"]] != true) and (!isset($_GET["token"]) or $_GET["token"] == "")) {
		$return["message"] = "No valid token given!";

		echo json_encode($return);
		return;
	}

	// Log API Calls

	// Include
	if(!file_exists($file)) {
		$return["message"] = "Method not found!";

		echo json_encode($return);
		return;
	}

	// Save return data
	list(
		$return["status"],
		$return["result"],
		$return["message"],
	) = include($file);

	// Return it to the MTA Server
	echo json_encode($return);
?>
