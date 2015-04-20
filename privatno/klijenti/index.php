<?php
include_once '../../konfiguracija.php';

if (!isset($_SESSION[$ida . "operater"]) || $_SESSION[$ida . "operater"]->uloga != "administrator") {
	header("location: ../../odjavi.php");
}

$uvjet = "";
$preduvjet = "concat(b.ime,' ',b.prezime)";

if ($_POST) {
	$uvjet = $_POST["uvjet"];
	$preduvjet = $_POST["preduvjet"];
	
	switch ($preduvjet) {
    case 1:
        $preduvjet = "b.oib";
        break;
    case 2:
        $preduvjet = "b.ime";
        break;
    case 3:
        $preduvjet = "b.prezime";
        break;
    case 4:
        $preduvjet = "b.mobitel";
        break;
    case 5:
        $preduvjet = "b.email";
        break;
}
		
} else if (isset($_GET["uvjet"]) && isset($_GET["preduvjet"])) {
	$uvjet = $_GET["uvjet"];
	$preduvjet = $_GET["preduvjet"];
} 


$uvjetZaUpit = "%" . $uvjet . "%";

$izraz = $veza -> prepare("select a.*,b.oib,b.ime,b.prezime,b.mobitel,b.email,c.aktivan from klijent a inner join osoba b on a.osoba=b.sifra inner join operater c on a.operater=c.sifra where " . $preduvjet . " like :uvjet");


$izraz -> bindParam(":uvjet", $uvjetZaUpit);

$izraz -> execute();



$klijent = $izraz -> fetchAll(PDO::FETCH_OBJ);
?>

<!doctype html>
<html class="no-js" lang="en">
	<head>

		<?php
		include_once '../../head.php';
		?>
	</head>
	

	
	<body>

		<?php
		include_once '../../zaglavlje.php';
		?>
		
		
		<div class="row">
			<div class="large-12 columns">
				
				<h4><i class="fi-torsos-all"> </i>Klijenti</h4>
				<hr />
				
	<form action="<?php echo $_SERVER["PHP_SELF"] ?>" method="post">
			

  <div class="row">
    <div class="large-3 columns">
      <input type="text" name="uvjet" id="uvjet" value="<?php echo $uvjet; ?>" />
    </div>
    <div class="large-2 columns">
      <input type="submit" class="button alert trazi" 
			value="Traži" />
    </div>
    <div class="large-2 columns">
    	<select id="preduvjet" name="preduvjet" class="filter">
						<option value = "1" <?php if($preduvjet == "b.oib"): echo  "selected = 'selected'" ; endif; ?>>Po OIB-u</option>
						<option value = "2" <?php if($preduvjet == "b.ime"): echo  "selected = 'selected'" ; endif; ?>>Po imenu</option>
						<option value = "3" <?php if($preduvjet == "b.prezime"): echo  "selected = 'selected'" ; endif; ?>>Po prezimenu</option>
						<option value = "4" <?php if($preduvjet == "b.mobitel"): echo  "selected = 'selected'" ; endif; ?>>Po mobitelu</option>
						<option value = "5" <?php if($preduvjet == "b.email"): echo  "selected = 'selected'" ; endif; ?>>Po e-mailu</option>
					</select>
    </div>
    <div class="large-3 columns">
      <a href="dodaj.php" class="button success dodaj"><i class="fi-plus"></i> Dodaj novog</a>
    </div>
    <div class="large-2 columns">
    <a href="../administracija.php" class="button alert nazad1"><i class="fi-arrow-left"></i> Nazad</a>
    </div>
  </div>

	</form>
	
				
<table class="reference" style="width:100%">
<tbody>
<tr>
	<th>Šifra</th>
	<th>OIB</th>
	<th>Ime</th>		
	<th>Prezime</th>
	<th>Mobitel</th>
	<th>E-mail</th>
	<th>Aktivan</th>
	<th>Opcije</th>

</tr>
<?php foreach ($klijent as $k): ?>
					

<tr>
	<td><?php echo $k -> sifra; ?></td>
	<td><?php echo $k -> oib; ?></td>
	<td><?php echo $k -> ime; ?></td>
	<td><?php echo $k -> prezime; ?></td>		
	<td><?php echo $k -> mobitel; ?></td>
	<td><?php echo $k -> email; ?></td>
	<td><input id="checkbox1" type="checkbox" <?php
		if ($k -> aktivan == 1) { echo "checked";}?>></td>
	<td>
		

	
	
	<ul class="button-group radius even-3">
	<li><a href="#" title="Pogledaj detalje"><i class="fi-zoom-in"></i></a></li>
  	<li><a href="promjeni.php?sifra=<?php echo $k->sifra; ?>" title="Promjeni"><i class="fi-loop"></i></a></li>
  	<!--
  	<li><a href="obrisiZaposlenika.php?sifra=<?php echo $z->sifra; ?>" data-reveal-id="myModal" class="obrisi" id="<?php echo $z->ime . " " . $z->prezime;?>" title="Obriši"><i class="fi-x"></i></a></li>
  -->
<?php  
  	$izraz = $veza -> prepare('select count(sifra) as ukupno from narudzba where klijent=:sifra');
$s = $k->sifra;
$izraz -> bindParam (":sifra", $s);
$izraz -> execute();
$ukupno = $izraz -> fetchColumn();

if($ukupno==0):
?>
  	<li><a href="obrisiKlijenta.php?sifra=<?php echo $k->sifra; ?>" data-reveal-id="myModal" class="obrisi" id="<?php echo $k->ime . " " . $k->prezime;?>" title="Obriši"><i class="fi-x"></i></a></li>
  	<?php
else:
?>
<li><a href="#" data-reveal-id="myModal1" title="Obriši"><i class="fi-x"></i></a></li>
<?php

endif;
?>
</ul>

</td>
</tr>

<?php endforeach; ?>
</tbody>
</table>
					
					
				
				
			</div>
		</div>
		
				
		<?php
	
		include_once 'modalBrisanje.php';
		include_once 'modalUpozorenje.php';
		?>

	
		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
		
		<script>
									$(document).foundation();  
	$('a.obrisi').click(function(){
    var link = $('.deleteUrl');
    $(link).attr('href', this.href);
    
 	var tekst = $('.tekst');
 	 $(tekst).text("Želite obrisati klijenta ("+this.id+") ?");
});
		</script>

	</body>
</html>
