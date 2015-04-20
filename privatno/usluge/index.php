<?php
include_once '../../konfiguracija.php';


$izraz = $veza -> prepare("select * from usluga");

$izraz -> execute();

$usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
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
				
				<h4><i class="fi-price-tag"> </i>Usluge</h4>
				<hr />
				
 
      <a href="dodaj.php" class="button success dodaj2" data-reveal-id="modalDodajUslugu"><i class="fi-plus"></i> Dodaj novu</a>

 
    <a href="../administracija.php" class="button alert nazad2"><i class="fi-arrow-left"></i> Nazad</a>

				
<table class="reference" style="width:100%">
<tbody>
<tr>
	<th>Šifra</th>
	<th>Naziv</th>
	<th>Datum unosa</th>		
	<th>Datum promjene</th>
	<th>Opcije</th>

</tr>
<?php foreach ($usluga as $u): ?>
					

<tr>
	<td><?php echo $u -> sifra; ?></td>
	<td><?php echo $u -> naziv; ?></td>
	<?php $date = date_create($u -> datumunosa); ?>											
	<td><?php echo date_format($date, 'd.m.Y. H:i:s'); ?></td>
	<?php $date = date_create($u -> datumpromjene); ?>												
	<td><?php echo date_format($date, 'd.m.Y. H:i:s'); ?></td>
	
				

	<td>
		
	<ul class="button-group radius even-3">
	<li><a href="#" title="Pogledaj detalje"><i class="fi-zoom-in"></i></a></li>
  	<li><a href="modalPromjeniUslugu.php?sifra=<?php echo $u->sifra; ?>"><i id="<?php echo $u->sifra; ?>" class="fi-loop promjeniUslugu"></i></a></li>
  	
  	<?php  
  	$izraz = $veza -> prepare('select count(narudzba) as ukupno from narudzba_usluga where usluga=:sifra');
$s = $u->sifra;
$izraz -> bindParam (":sifra", $s);
$izraz -> execute();
$ukupno = $izraz -> fetchColumn();

if($ukupno==0):
?>
  	
  	
  	<li><a href="obrisiUslugu.php?sifra=<?php echo $u->sifra; ?>" data-reveal-id="myModal" class="obrisi" id="<?php echo $u->naziv;?>" title="Obriši"><i class="fi-x"></i></a></li>
  	
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
		include_once 'modalDodajUslugu.php';
		include_once 'modalPromjeniUslugu.php';
		include_once 'modalUpozorenje.php';
		
		?>

	
		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
		
					<script>
					
					$('#promjeniUslugu2').click(function(event) {
					
				event.preventDefault();
				
				$('#naziv').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				//PROVJERA USLUGE

					var naziv = $('#naziv').val();
					var naziv_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

					if (naziv.length == 0) {

						$('#naziv').tooltipster('content', 'Ovo polje je obavezno.');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}

					if (!naziv.match(naziv_regex)) {

						$('#naziv').tooltipster('content', 'Dozvoljena samo slova. 2-50');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}
					
				
					
					
				var forma = $(this).closest("form");;
				
				var podaci = forma.serialize();
				
				var url = forma.attr('action');
				

			//	alert(podaci);

					
					$.ajax({
						type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								window.location = "index.php";

							}

						}
					});
					
				

					
				});
					
					
					
					
					
					
					
					
					
					
		
						$(".promjeniUslugu").click(function(){
			//	alert($(this).attr("id"));
				
				$.ajax({
						type : "GET",
						url : "promjeni.php?sifra=" + $(this).attr("id"),
						cache : false,
						success : function(data) {

							$("#kontejner").html(data);
							$('#modalPromjeniUslugu').foundation('reveal','open');
						}
					});
				
				
				
				
				return false;
			});
					
					
					
					
					
					
					
					
					
			$(document).foundation();  
	$('a.obrisi').click(function(){
    var link = $('.deleteUrl');
    $(link).attr('href', this.href);
    
 	var tekst = $('.tekst');
 	 $(tekst).text("Želite obrisati uslugu ("+this.id+") ?");
});


	$('#dodajUslugu').click(function(event) {
					
				event.preventDefault();
				
				$('#naziv').tooltipster({
					position : 'right',
					offsetX : '5px',
					offsetY : '-19px',
					trigger : 'custom'

				});
				
				//PROVJERA USLUGE

					var naziv = $('#naziv').val();
					var naziv_regex = /^[a-zA-Z ćĆčČđĐšŠžŽ]{2,50}$/;

					if (naziv.length == 0) {

						$('#naziv').tooltipster('content', 'Ovo polje je obavezno.');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}

					if (!naziv.match(naziv_regex)) {

						$('#naziv').tooltipster('content', 'Dozvoljena samo slova. 2-50');
						$('#naziv').tooltipster('show');
						$('#naziv').focus();
						return false;
					}
				
					
					
				var forma = $("#myform");
				
				var podaci = forma.serialize();
				
				var url = forma.attr('action');
				
			//	var alertBox = $('.alertPasPromjenjen');

				//alert(podaci);

					
					$.ajax({
						type : "POST",
						url : url,
						data : podaci,
						cache : false,
						success : function(data) {

							if (data == "OK") {

								window.location = "index.php";

							}

						}
					});
					
				

					
				});
				
				



		</script>

	</body>
</html>
