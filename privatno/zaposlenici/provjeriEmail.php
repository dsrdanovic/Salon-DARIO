<?php

include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("select * from osoba where email=:email and sifra!=:sifraOsobe");

$email=$_POST['email'];
$sifraOsobe=$_POST['sifraOsobe'];


	$izraz -> bindParam(':email', $email, PDO::PARAM_STR);
	$izraz -> bindParam(':sifraOsobe', $sifraOsobe, PDO::PARAM_STR);
	$izraz -> execute();
	$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($osoba==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
