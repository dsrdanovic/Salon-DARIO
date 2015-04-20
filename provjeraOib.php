<?php

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("select * from osoba where oib=:oib");

$o=$_POST['oib'];
	$izraz -> bindParam(':oib', $o, PDO::PARAM_STR);
	$izraz -> execute();
	$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($osoba==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
