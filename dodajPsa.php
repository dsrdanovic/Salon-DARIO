<?php

include_once 'konfiguracija.php';

if ($_POST) {
	
	//INSERT PAS

	$operater = $_SESSION[$ida . "operater"]->sifra;
	$klijent = $_POST["klijent"];
	
	$izraz = $veza -> prepare("insert into pas (ime,pasmina,klijent,slika,datumunosa,datumpromjene,operater) values (:ime,:pasmina,:klijent,null,now(),now(),:operater)");
	$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
	$izraz -> bindParam(':pasmina', $_POST['pasmina'], PDO::PARAM_STR);
	$izraz -> bindParam(':klijent', $klijent, PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);
	
	$izraz -> execute();
	
	
	
}

echo "OK";

