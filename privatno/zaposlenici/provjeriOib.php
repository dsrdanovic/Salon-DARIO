<?php

include_once '../../konfiguracija.php';

$izraz = $veza -> prepare("select * from osoba where oib=:oib and sifra!=:sifraOsobe");

$oib=$_POST['oib'];
$sifraOsobe=$_POST['sifraOsobe'];


	$izraz -> bindParam(':oib', $oib, PDO::PARAM_STR);
	$izraz -> bindParam(':sifraOsobe', $sifraOsobe, PDO::PARAM_STR);
	$izraz -> execute();
	$osoba = $izraz -> fetch(PDO::FETCH_OBJ);

	
	if($osoba==null){
		echo "NEPOSTOJI";
	}
	else{
		echo "POSTOJI";
	}
