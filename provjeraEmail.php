<?php

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("select * from osoba where email=:email");

$e=$_POST['email'];
	$izraz -> bindParam(':email', $e, PDO::PARAM_STR);
	$izraz -> execute();
	$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($osoba==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
