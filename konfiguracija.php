<?php
session_start();

// Lokalno

 $putanjaApp = "/wp10/DARIO/";
 $mysql_host = "localhost";
 $mysql_database = "salondario";
 $mysql_user = "edunova";
 $mysql_password = "edunova";
 
 $ida="SalonDARIO";

 // 000webhost
/*
 $putanjaApp="/";
 $mysql_host = "mysql1.000webhost.com";
 $mysql_database = "a3209125_dario";
 $mysql_user = "a3209125_dario";
 $mysql_password = "Dario123.";
 */ 

// Hostinger.hr
/*
$putanjaApp = "/";
$mysql_host = "mysql.hostinger.hr";
$mysql_database = "u163058598_dario";
$mysql_user = "u163058598_dario";
$mysql_password = "";
$ida="SalonDARIO";
*/
 
try {
	$veza = new PDO('mysql:host=' . $mysql_host . ';dbname=' . $mysql_database . ';charset=utf8', $mysql_user, $mysql_password);
	$veza -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	$veza ->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
} catch (PDOException $ex) {
	if ($ex -> getCode() == 2002) {
		header("location: greska.php");
	}

}



