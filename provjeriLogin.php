<?php

include_once 'konfiguracija.php';

if(isset($_SESSION[$ida . "operater"]) && $_SESSION[$ida . "operater"]->uloga=="korisnik"){
	echo "KORISNIK";
								
}elseif (isset($_SESSION[$ida . "operater"]) && $_SESSION[$ida . "operater"]->uloga=="administrator"){
	echo "ADMINISTRATOR";
	
}else{ 
	
	echo "FAIL";
}
								