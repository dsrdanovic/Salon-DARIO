<?php
include_once '../../konfiguracija.php';


if (isset($_GET["stranica"])) {
	$stranica = $_GET["stranica"];
} else {
	$stranica = 1;
}

$uvjet = "";
$preduvjet = "naselje";

if ($_POST) {
	$uvjet = $_POST["uvjet"];
	$preduvjet = $_POST["preduvjet"];
	
	switch ($preduvjet) {
    case 1:
        $preduvjet = "naselje";
        break;
    case 2:
        $preduvjet = "postanskibroj";
        break;
    case 3:
        $preduvjet = "opcina";
        break;
    case 4:
        $preduvjet = "zupanija";
        break;
}
		
} else if (isset($_GET["uvjet"]) && isset($_GET["preduvjet"])) {
	$uvjet = $_GET["uvjet"];
	$preduvjet = $_GET["preduvjet"];
} 


$uvjetZaUpit = "%" . $uvjet . "%";

$izraz = $veza -> prepare("select * from mjesto where " . $preduvjet . " like :uvjet limit " . (($stranica * 20)-20) . ",20");
$izraz -> bindParam(":uvjet", $uvjetZaUpit);
$izraz -> execute();
$mjesto = $izraz -> fetchAll(PDO::FETCH_OBJ);



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
				
				<h4><i class="fi-target"> </i>Mjesta</h4>
				<hr />
				
	<form action="<?php echo $_SERVER["PHP_SELF"] ?>" method="post">
			

  <div class="row">
    <div class="large-3 columns">
      <input type="text" id="uvjet" name="uvjet" value="<?php echo $uvjet; ?>" />
    </div>
    <div class="large-2 columns">
      <input type="submit" class="button alert trazi" 
			value="Traži" />
    </div>
    <div class="large-2 columns">
    	<select id="preduvjet" name="preduvjet" class="filter">
						<option value = "1" <?php if($preduvjet == "naselje"): echo  "selected = 'selected'" ; endif; ?>>Po naselju</option>
						<option value = "2" <?php if($preduvjet == "postanskibroj"): echo  "selected = 'selected'" ; endif; ?>>Po poštanskom broju</option>
						<option value = "3" <?php if($preduvjet == "opcina"): echo  "selected = 'selected'" ; endif; ?>>Po općini</option>
						<option value = "4" <?php if($preduvjet == "zupanija"): echo  "selected = 'selected'" ; endif; ?>>Po županiji</option>
					</select>
    </div>
    <div class="large-3 columns">
      <a href="dodaj.php" class="button success dodaj"><i class="fi-plus"></i> Dodaj novo</a>
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
	<th>Naselje</th>
	<th>Poštanski broj</th>		
	<th>Općina</th>
	<th>Županija</th>
	<th>Opcije</th>

</tr>
<?php foreach ($mjesto as $m): ?>
					

<tr>
	<td><?php echo $m -> sifra; ?></td>
	<td><?php echo $m -> naselje; ?></td>
	<td><?php echo $m -> postanskibroj; ?></td>
	<td><?php echo $m -> opcina; ?></td>		
	<td><?php echo $m -> zupanija; ?></td>
	<td>
	<ul class="button-group radius even-3">
	<li><a href="#" title="Pogledaj detalje"><i class="fi-zoom-in"></i></a></li>
  	<li><a href="promjeni.php?sifra=<?php echo $m->sifra; ?>" title="Promjeni"><i class="fi-loop"></i></a></li>
  	<li><a href="obrisiMjesto.php?sifra=<?php echo $m->sifra; ?>" data-reveal-id="myModal" class="obrisi" id="<?php echo $m->naselje;?>" title="Obriši"><i class="fi-x"></i></a></li>
  
</ul>

</td>
</tr>

<?php endforeach; ?>
</tbody>
</table>
					
					
				
				
			</div>
		</div>
		
		<!-- straničenje -->
		<div class="row">
			<div class="large-12 columns">
					
		<ul class="pagination">
  			<li class="arrow"><a href="index.php?stranica=<?php

					if ($stranica > 1) {
						$prethodna = $stranica - 1;
						echo $prethodna;
					} else {
						echo 1;
					}
					?>&uvjet=<?php echo $uvjet ?>">&laquo; Prethodna</a></li>
					
  		
  			<li class="current"><a href=""><?php echo $stranica;?></a></li>
  		
  			
  			<li class="arrow"><a href="index.php?stranica=<?php

					echo ++$stranica;
					?>&uvjet=<?php echo $uvjet ?>">Slijedeća &raquo;</a></li>
		</ul>
				
			</div>	
		</div>

		
				
		<?php
	
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
 	 $(tekst).text("Želite obrisati mjesto ("+this.id+") ?");
});
		</script>

	</body>
</html>
