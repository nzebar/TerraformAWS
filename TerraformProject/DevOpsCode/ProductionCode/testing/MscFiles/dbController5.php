<?php

/* Nate gathered together the credentials to authenticate into the cart(Database) then products (tablename) of the  RDS mySQL Database */
class DBController {
	private $host = "boltzdb-1.csfsc1k3p4ig.us-east-1.rds.amazonaws.com";
	private $user = "PurpleB01";
	private $password = "ScrumCapstone";
	private $database = "cart";
	private $conn;

/* This is the function used to start up a connection to the mySQL Database using the connectDB() function */
	function __construct() {
		$this->conn = $this->connectDB();
	}

/* This is the function used to create a connection to database using the credentials set as variables stated above, 
More specifically the connection being created is a mysqli connection which is different than other connection types with PHP */	
	function connectDB() {
		$conn = mysqli_connect($this->host,$this->user,$this->password,$this->database);
		return $conn;
	}
	
	function runQuery($query) {
		$result = mysqli_query($this->conn,$query);
		while($row=mysqli_fetch_assoc($result)) {
			$resultset[] = $row;
		}		
		if(!empty($resultset))
			return $resultset;
	}
	
	function numRows($query) {
		$result  = mysqli_query($this->conn,$query);
		$rowcount = mysqli_num_rows($result);
		return $rowcount;	
	}
}
?>
