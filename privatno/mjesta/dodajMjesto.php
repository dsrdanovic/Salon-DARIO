<?php

include_once '../../konfiguracija.php';

if ($_POST) {

	//INSERT MJESTO

	$izraz = $veza -> prepare("insert into mjesto (naselje,postanskibroj,opcina,zupanija) values (:naselje,:postanskibroj,:opcina,:zupanija)");
	$izraz -> bindParam(':naselje', $_POST['naselje'], PDO::PARAM_STR);
	$izraz -> bindParam(':postanskibroj', $_POST['postanskibroj'], PDO::PARAM_STR);
	$izraz -> bindParam(':opcina', $_POST['opcina'], PDO::PARAM_STR);
	$izraz -> bindParam(':zupanija', $_POST['zupanija'], PDO::PARAM_STR);

	$izraz -> execute();

}

echo "OK";


