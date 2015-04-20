<?php

include_once '../../konfiguracija.php';

if ($_POST) {
	
	//INSERT USLUGA

	$operater = $_SESSION[$ida . "operater"]->sifra;
	
	$izraz = $veza -> prepare("insert into usluga (naziv,datumunosa,datumpromjene,operater) values (:naziv,now(),now(),:operater)");
	$izraz -> bindParam(':naziv', $_POST['naziv'], PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);
	
	$izraz -> execute();
	
}

echo "OK";

