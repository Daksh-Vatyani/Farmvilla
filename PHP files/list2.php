<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$email = $obj['email'];
	$sql="select Guest from Guests";
	$result = $con->query($sql);
	$row = array();
	if ($result) {
	    while ($tmp = $result->fetch_assoc()) {
		$row[]= $tmp;
	    }
	    	$json = json_encode($row);
	} 
	
	echo $json;
	mysqli_close($con);


 
?>