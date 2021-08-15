<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$email = $obj['email'];
	$guest = $obj['guest'];	
    $query = "UPDATE Guests SET Status='Accepted' WHERE email='$email' and Guest='$guest'";
    $results = mysqli_query($con, $query);
?>