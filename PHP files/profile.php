<?php 
    require_once "conn.php";

 $email = $_POST['email'];
 $fname = $_POST['fname'];
 $lname = $_POST['lname'];
 $mobile = $_POST['mobile'];
 $property = $_POST['property'];
 $image = $_POST['image'];
 $name = $_POST['name'];
    
    $img = base64_decode($image);
    $image = $name;
    file_put_contents($image, $img);
 $loginQuery = "select * from profile where email = '$email' ";
 $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));
 
	if(isset($check)){
	    $query = "UPDATE profile SET fname='$fname' WHERE email='$email'";
    $results = mysqli_query($con, $query);
    $query = "UPDATE profile SET lname='$lname' WHERE email='$email'";
    $results = mysqli_query($con, $query);
    $query = "UPDATE profile SET mobile='$mobile' WHERE email='$email'";
    $results = mysqli_query($con, $query);
    $query = "UPDATE profile SET property='$property' WHERE email='$email'";
    $results = mysqli_query($con, $query);
    $query = "UPDATE profile SET photo='$image' WHERE email='$email'";
    $results = mysqli_query($con, $query);
		if($results)
		{
		 $onLoginSuccess = 'Successful';
		 $SuccessMSG = json_encode($onLoginSuccess);
		 echo $SuccessMSG ; 
		}
	 }
	 
	 else{
	 
		$InvalidMSG = 'Failed to insert data' ;
		 
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 
		 echo $InvalidMSGJSon ;
	 
	 }
 
 mysqli_close($con);
?>