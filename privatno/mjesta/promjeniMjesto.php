<?php

include_once '../../konfiguracija.php';

if($_POST){
	
$operater = $_SESSION[$ida . "operater"]->sifra;

$izraz = $veza -> prepare("update mjesto set naselje=:naselje,postanskibroj=:postanskibroj,opcina=:opcina,zupanija=:zupanija,datumpromjene=now(),operater=:operater where sifra=:sifra");
$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
$izraz -> bindParam(':naselje', $_POST['naselje'], PDO::PARAM_STR);
$izraz -> bindParam(':postanskibroj', $_POST['postanskibroj'], PDO::PARAM_STR);
$izraz -> bindParam(':opcina', $_POST['opcina'], PDO::PARAM_STR);
$izraz -> bindParam(':zupanija', $_POST['zupanija'], PDO::PARAM_STR);
$izraz -> bindParam(':operater', $operater, PDO::PARAM_STR);

$izraz -> execute();

}

echo "OK";

