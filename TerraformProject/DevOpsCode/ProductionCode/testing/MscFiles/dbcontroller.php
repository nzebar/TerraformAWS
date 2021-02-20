<?php
class DBController {
	private $host = "localhost";
	private $user = "root";
	private $password = "Root@123456789";
	private $database = "cart";
	
	function __construct() {
		$conn = $this->connectDB();
		if(!empty($conn)) {
			$this->selectDB($conn);
		}
	};
	
	function connectDB() {
		$conn = mysqli_connect($host, $user, $password, $database);
		if (mysqli_connect_errno()){
			echo "The database did not receive any love:" . mysqli_connect_errno();
		}
	};	
	
	$query = "SELECT ROW * FROM products";
	
	if ($result = $conn->query($query)){
	    $row = $result->fetch_assoc()
		};
		    	    
	if ($row = $result->fetch_assoc()){
	$rowcount = $row->num_rows
	};
	return $rowcount;	
	
	$query = close();

	$conn->close();
}
?>
