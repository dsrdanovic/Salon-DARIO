<?php
include_once '../../konfiguracija.php';

$uvjet = "";
$preduvjet = "c.ime";

if ($_POST) {
	$uvjet = $_POST["uvjet"];
	$preduvjet = $_POST["preduvjet"];
	
	switch ($preduvjet) {
    case 1:
        $preduvjet = "c.ime";
        break;
    case 2:
        $preduvjet = "d.naziv";
        break;
    case 3:
        $preduvjet = "concat(a.ime,' ',a.prezime)";
        break;
}
		
} else if (isset($_GET["uvjet"]) && isset($_GET["preduvjet"])) {
	$uvjet = $_GET["uvjet"];
	$preduvjet = $_GET["preduvjet"];
} 


$uvjetZaUpit = "%" . $uvjet . "%";

$izraz = $veza -> prepare("select a.ime as imeVlasnika,a.prezime as prezimeVlasnika,c.*,d.naziv from osoba a inner join klijent b on a.sifra=b.osoba inner join pas c on b.sifra=c.klijent inner join pasmina d on c.pasmina=d.sifra where " . $preduvjet . " like :uvjet order by c.sifra asc");


$izraz -> bindParam(":uvjet", $uvjetZaUpit);

$izraz -> execute();



$pas = $izraz -> fetchAll(PDO::FETCH_OBJ);

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
				
				<h4><i class="fi-guide-dog"> </i>Psi</h4>
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
						<option value = "1" <?php if($preduvjet == "c.ime"): echo  "selected = 'selected'" ; endif; ?>>Po imenu</option>
						<option value = "2" <?php if($preduvjet == "d.naziv"): echo  "selected = 'selected'" ; endif; ?>>Po pasmini</option>
						<option value = "3" <?php if($preduvjet == "concat(a.ime,' ',a.prezime)"): echo  "selected = 'selected'" ; endif; ?>>Po vlasinku</option>
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
	<th>Ime</th>
	<th>Pasmina</th>		
	<th>Vlasnik</th>
	<th>Zadnji posjet</th>
	<th>Opcije</th>

</tr>
<?php foreach ($pas as $p): ?>
					

<tr>
	<td><?php echo $p -> sifra; ?></td>
	<td><?php echo $p -> ime; ?></td>
	<td><?php echo $p -> naziv; ?></td>
	<td><?php echo $p -> imeVlasnika . " " . $p->prezimeVlasnika; ?></td>
	<td><?php echo "???"; ?></td>	
	



	<td>	
	<ul class="button-group radius even-3">
	<li><a href="#" title="Pogledaj detalje"><i class="fi-zoom-in"></i></a></li>
  	<li><a href="promjeni.php?sifra=<?php echo $p->sifra; ?>" title="Promjeni"><i class="fi-loop"></i></a></li>
  	
  
  
  <?php  
  	$izraz = $veza -> prepare('select count(sifra) as ukupno from narudzba where pas=:sifra');
$s = $p->sifra;
$izraz -> bindParam (":sifra", $s);
$izraz -> execute();
$ukupno = $izraz -> fetchColumn();

if($ukupno==0):
?>
  	<li><a href="obrisiPsa.php?sifra=<?php echo $p->sifra; ?>" data-reveal-id="myModal" class="obrisi" id="<?php echo $p->ime;?>" title="Obriši"><i class="fi-x"></i></a></li>
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
		include_once 'modalUpozorenje.php';
		include_once 'modalBrisanje.php';
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
 	 $(tekst).text("Želite obrisati psa ("+this.id+") ?");
});
		</script>

	</body>
</html>
