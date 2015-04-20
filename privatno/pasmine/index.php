<?php
include_once '../../konfiguracija.php';

$uvjet = "";

if ($_POST) {
	$uvjet = $_POST["uvjet"];
		
} else if (isset($_GET["uvjet"])) {
	$uvjet = $_GET["uvjet"];
	
} 


$uvjetZaUpit = "%" . $uvjet . "%";

$izraz = $veza -> prepare("select * from pasmina where naziv like :uvjet");

$izraz -> bindParam(":uvjet", $uvjetZaUpit);

$izraz -> execute();

$pasmina = $izraz -> fetchAll(PDO::FETCH_OBJ);

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
				
				<h4><i class="fi-braille"> </i>Pasmine</h4>
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

    <div class="large-3 columns">
      <a href="dodaj.php" class="button success dodaj1"><i class="fi-plus"></i> Dodaj novu</a>
    </div>
    <div class="large-2 columns">
    <a href="../administracija.php" class="button alert nazad1"><i class="fi-arrow-left"></i> Nazad</a>
    </div>
  </div>

	</form>
	
				
<div class="row">
<?php foreach ($pasmina as $p): 
	
	$dat = $_SERVER["CONTEXT_DOCUMENT_ROOT"] . $putanjaApp."img/pasmine/". $p->slika;
				//print_r($dat);
				if(file_exists($dat)){
					$slika=$putanjaApp . "img/pasmine/". $p->slika;
				}
				else{
					
					$slika=$putanjaApp . "img/pasmine/nemaSlike.png";
				}
					
?>
<div class="large-6 columns end">
					<div class="panel rezultati">
					<div class="row">
						<div class="large-6 columns">
							
							<img class="slika" alt="" src="<?php echo $slika; ?>" />
							</div>
							<div class="large-6 columns">
								
									<b>
									<?php echo $p -> naziv; ?>
								</b>
												<div class="row">
						<div class="large-12 columns">
							<hr />
										<ul class="button-group round even-2">
  	<li><a href="promjeni.php?sifra=<?php echo $p->sifra; ?>" class="button success promjeniPasminu" title="Promjeni"><i class="fi-loop"></i></a></li>
  	<?php

$izraz = $veza -> prepare('select count(sifra) as ukupno from pas where pasmina=:sifra');
$s = $p->sifra;
$izraz -> bindParam (":sifra", $s);
$izraz -> execute();
$ukupno = $izraz -> fetchColumn();

if($ukupno==0):
?>
  	<li><a href="obrisiPasminu.php?sifra=<?php echo $p->sifra; ?>" data-reveal-id="myModal" class="button alert obrisiPasminu obrisi" id="<?php echo $p->naziv;?>" title="Obriši"><i class="fi-x"></i></a></li>
  	<?php
else:
?>
<li><a href="#" data-reveal-id="myModal1" class="button alert obrisiPasminu" title="Obriši"><i class="fi-x"></i></a></li>
<?php

endif;
?>
  	</ul>
									</div>
								</div>							
							
							</div>
						</div>
					
					</div>
				</div>
		

	
	
	



		<?php endforeach; ?>
		</div>
					
					
				
				
		<?php	
		include_once 'modalBrisanje.php';
		?>
		
		<?php	
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
 	 $(tekst).text("Želite obrisati pasminu ("+this.id+") ?");
});
		</script>

	</body>
</html>
