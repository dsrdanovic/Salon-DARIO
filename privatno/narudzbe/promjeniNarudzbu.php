<?php

include_once '../../konfiguracija.php';

function startsWith($haystack, $needle) {
    // search backwards starting from haystack length characters from the end
    return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== FALSE;
}

if ($_POST) {

	//print_r($_POST);
	$cijene=array();
	foreach ($_POST as $key => $value) {
		if(startsWith($key,"cijena_")){
			 $usluga = new stdClass();
			$usluga->sifra = explode("_", $key)[1];
			$usluga->cijena=$value;
			array_push($cijene,$usluga);
		}
	}

	$veza -> beginTransaction();

	//UPDATE NARUDŽBA

	$d = $_POST["datumnarudzbe"];
	$datumNarudzbe = substr($d, 6, 4) . "-" . substr($d, 3, 2) . "-" . substr($d, 0, 2);

	$operater = $_SESSION[$ida . "operater"] -> sifra;

	$izraz = $veza -> prepare("update narudzba set zaposlenik=:zaposlenik,datumnarudzbe=:datumnarudzbe,termin=:termin,dan=:dan,status=:status,datumpromjene=now(),operater=:operater where sifra=:sifra");
	$izraz -> bindParam(':zaposlenik', $_POST["sifraZaposlenika"], PDO::PARAM_INT);
	$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
	$izraz -> bindParam(':datumnarudzbe', $datumNarudzbe, PDO::PARAM_STR);
	$izraz -> bindParam(':termin', $_POST['termin'], PDO::PARAM_STR);

	if (!isset($_POST["status"])) {
		$status = 0;
	} else if ($_POST["status"] == "on") {
		$status = 1;
	}

	$izraz -> bindParam(':status', $status, PDO::PARAM_INT);
	$izraz -> bindParam(':dan', $_POST['dan'], PDO::PARAM_STR);
	$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);

	$izraz -> execute();

	$izraz = $veza -> prepare("delete from narudzba_usluga where narudzba=:sifra");
	$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
	$izraz -> execute();

	
	foreach ($_POST["usluga"] as $u) {
		foreach ($cijene as $c) {
			if($u==$c->sifra){
				$izraz = $veza -> prepare("insert into narudzba_usluga (narudzba,usluga, cijena) values (:narudzba,:usluga,:cijena)");
				$izraz -> bindParam(':narudzba', $_POST['sifra'], PDO::PARAM_STR);
				$izraz -> bindParam(':usluga', $c->sifra, PDO::PARAM_INT);
				$izraz -> bindParam(':cijena', $c->cijena, PDO::PARAM_STR);
	
				$izraz -> execute();
			}
		}
	
	}


}

$veza -> commit();

echo "OK";
