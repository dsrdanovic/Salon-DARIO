<?php

include_once '../../konfiguracija.php';

if ($_POST) {
	
	//UPDATE USLUGA

	$operater = $_SESSION[$ida . "operater"]->sifra;
	
	$izraz = $veza -> prepare("update usluga set naziv=:naziv,datumpromjene=now(),operater=:operater where sifra=:sifra");
	$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
	$izraz -> bindParam(':naziv', $_POST['naziv'], PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);
	
	$izraz -> execute();
	
}

echo "OK";


