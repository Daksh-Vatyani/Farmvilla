<?php 
	require_once "conn.php";
	$json = file_get_contents('php://input');
	$obj = json_decode($json,true);
	$email = $obj['email'];
	$password = $obj['password'];
	$CheckSQL = "SELECT * FROM profile WHERE email='$email'";
	$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
	if(isset($check)){
		 $emailExist = 'Email Already Exist, Please Try Again With New Email Address..!';
		$existEmailJSON = json_encode($emailExist);
		 echo $existEmailJSON ; 
	}
	 else{
		$query = "INSERT INTO profile(email,password,fname,lname,mobile,property,photo) VALUES( '$email','$password','null','null','null','null','null')";
		$results = mysqli_query($con, $query);
		if($results)
		{
			$MSG = 'Registered Successfully' ;
			$json = json_encode($MSG);
			echo $json ;
		}
		else
		{
			echo "error";
		}
	 }
?>