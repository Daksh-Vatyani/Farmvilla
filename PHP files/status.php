<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$email = $obj['email'];
	$guest = $obj['guest'];
	$sql="select * from Guests where email='$email' and Guest = '$guest'  ";
	$result = $con->query($sql);
	$row = array();
	if ($result->num_rows > 0) {
	    while ($tmp = $result->fetch_assoc()) {
		$row[]= $tmp;
		$json = json_encode($row);
	    }
	} else {
	    $json = json_encode("No Data Found");
	}
	echo $json;
	mysqli_close($con);


 
?>