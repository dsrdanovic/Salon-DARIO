<?php

include_once '../../konfiguracija.php';

//print_r($_POST);

if ($_POST) {
	
						$target_dir = "../../img/pasmine/";
						$naziv = basename($_FILES["imgFile"]["name"]);
						$target_file = $target_dir . $naziv;
														
				move_uploaded_file($_FILES["imgFile"]["tmp_name"], $target_file);
				
				$operater = $_SESSION[$ida . "operater"]->sifra;
				
				if($naziv==""){
					$naziv=="nemaSlike.png";
				}

	$izraz = $veza -> prepare("update pasmina set naziv=:naziv,slika=:slika,datumpromjene=now(),operater=:operater where sifra=:sifra");
	$izraz -> bindParam(':naziv', $_POST['naziv'], PDO::PARAM_STR);
	$izraz -> bindParam(':slika', $naziv, PDO::PARAM_STR);
	$izraz -> bindParam(':operater',$operater, PDO::PARAM_STR);
	$izraz -> bindParam(':sifra',$_POST["sifra"], PDO::PARAM_STR);
	$izraz -> execute();

}

echo "OK";



