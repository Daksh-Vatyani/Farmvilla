<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$name = $obj['name'];
	$sql="select * from Guests where Guest = '$name'";
	$result = $con->query($sql);
	$row = array();
	if ($result->num_rows > 0) {
	    while ($tmp = $result->fetch_assoc()) {
		$row[]= $tmp;
		$json = json_encode($row);
	    }
	} else {
	    $json = json_encode("No record found");
	}
	echo $json;
	$con->close();
?>