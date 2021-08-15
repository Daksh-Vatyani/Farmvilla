<?php 
    require_once "conn.php";
 $json = file_get_contents('php://input');
 $obj = json_decode($json,true);
 $email = $obj['email'];
 $sql="select * from profile where email = '$email' ";
 $result = $con->query($sql);
$row = array();
if ($result->num_rows > 0) {

    while ($tmp = $result->fetch_assoc()) {

        $row[]= $tmp;

        $json = json_encode($row);
    }
} 
else {
    echo json_encode("No Data Found");
}
echo $json;

$con->close();
?>