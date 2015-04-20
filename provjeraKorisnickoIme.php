<?php

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("select * from operater where korisnickoime=:korisnickoime");

$k=$_POST['korisnickoime'];
	$izraz -> bindParam(':korisnickoime', $k, PDO::PARAM_STR);
	$izraz -> execute();
	$operater = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($operater==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
