<?php

include_once 'konfiguracija.php';

$izraz = $veza -> prepare("update pas set pasmina=:pasmina,ime=:ime,datumpromjene=now() where sifra=:sifra");

$izraz -> bindParam(':pasmina', $_POST['pasmina'], PDO::PARAM_STR);
$izraz -> bindParam(':ime', $_POST['ime'], PDO::PARAM_STR);
$izraz -> bindParam(':sifra', $_POST['sifra'], PDO::PARAM_STR);
//$izraz -> bindParam(':slika', $_POST['slika'], PDO::PARAM_STR);
$izraz -> execute();


echo "OK";
