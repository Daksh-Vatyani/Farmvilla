<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$email = $obj['email'];
	$guest = $obj['guest'];
	$status = $obj['status'];


	$q="INSERT into Guests (email, Guest, Status) VALUES('$email','$guest','$status')";
	$results = mysqli_query($con, $q);
	
	
	mysqli_close($con);

?>