<?php

include_once '../../konfiguracija.php';

if ($_POST) {
	
	//UPDATE PAS

	$operater = $_SESSION[$ida . "operater"]->sifra;
	
	$izraz = $veza -> prepare("update pas set ime=:ime,pasmina=:pasmina,klijent=:klijent,datumpromjene=now(),operater=:operater where sifra=:sifra");
	$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
	$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
	$izraz -> bindParam(':pasmina', $_POST['pasmina'], PDO::PARAM_STR);
	$izraz -> bindParam(':klijent', $_POST['klijent'], PDO::PARAM_STR);
//stavljeno null u upitu	$izraz -> bindParam(':slika', null);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);
	
	$izraz -> execute();
	
}

echo "OK";


