<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$fname = $obj['fname'];
	 $lname = $obj['lname'];
	 $mobile = $obj['mobile'];
	 $property = $obj['property'];
	$sql="select * from profile where fname = '$fname' AND lname='$lname ' AND mobile='$mobile' AND property='$property'";
	$result = $con->query($sql);
	$row = array();
	if ($result->num_rows > 0) {
	    while ($tmp = $result->fetch_assoc()) {
		$row[]= $tmp;
		$json = json_encode($row);
	    }
	} else {
	    $json = json_encode("QR Code Expired");
	}
	echo $json;
	$con->close();
?>