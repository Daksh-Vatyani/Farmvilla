<?php 
        require_once "conn.php";
	$json = file_get_contents('php://input');
	 $obj = json_decode($json,true);
	 $email = $obj['email'];
	 $password = $obj['password'];
	 $loginQuery = "select * from guard where email = '$email' and password = '$password' ";
	 $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));
	 if(isset($check)){
		 $onLoginSuccess = 'Login Matched';
		 $SuccessMSG = json_encode($onLoginSuccess);
		 echo $SuccessMSG ; 
	 }
	 else{
		$InvalidMSG = 'Invalid Username or Password Please Try Again' ;
		$InvalidMSGJSon = json_encode($InvalidMSG);
		 echo $InvalidMSGJSon ;
	 }
	mysqli_close($con);
?>