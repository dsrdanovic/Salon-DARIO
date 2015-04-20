<?php

include_once '../../konfiguracija.php';

if ($_POST) {

	$temporary = basename($_FILES["file"]["name"]);
	
	
	if (file_exists("../../img/pasmine/" . $_FILES["file"]["name"])) {
			
			echo "SLIKA POSTOJI S TIM NAZIVOM";
			return;
	
	} else {
				$sourcePath = $_FILES['file']['tmp_name'];
				$targetPath = "../../img/pasmine/" . $_FILES['file']['name'];
				move_uploaded_file($sourcePath, $targetPath);
	}
	
	$operater = $_SESSION[$ida . "operater"] -> sifra;

	if ($temporary == "") {
		$temporary = "nemaSlike.png";
	}

	$izraz = $veza -> prepare("insert into pasmina (naziv,slika,datumunosa,datumpromjene,operater) values (:naziv,:slika,now(),now(),:operater)");
	$izraz -> bindParam(':naziv', $_POST["naziv"], PDO::PARAM_STR);
	$izraz -> bindParam(':slika', $temporary, PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);
	$izraz -> execute();

	echo "OK";

}
