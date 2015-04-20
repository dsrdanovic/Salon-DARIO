<h4><i class="fi-info"></i> Detalji narudžbe</h4>
	<hr />
	<?php
	include_once '../../konfiguracija.php';
	$izraz = $veza -> prepare("select a.narudzba as sifraNarudzbe,a.usluga,a.cijena,b.naziv as nazivUsluge,b.sifra as sifraUsluge from narudzba_usluga a inner join usluga b on a.usluga=b.sifra where narudzba=:sifra");
	$izraz->bindParam("sifra",$_GET["sifra"]);
	$izraz -> execute();
	$narudzba_usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
	
	$izraz = $veza -> prepare("select * from usluga");
	$izraz -> execute();
	$usluga = $izraz -> fetchAll(PDO::FETCH_OBJ);
	
	$izraz = $veza -> prepare("select a.sifra,a.datumnarudzbe,a.termin,a.dan,a.status,a.napomena,a.datumunosa, b.ime as imePsa,c.naziv as nazivPasmine,e.ime as imeKlijenta, e.prezime as prezimeKlijenta from narudzba a inner join pas b on a.pas=b.sifra inner join pasmina c on b.pasmina=c.sifra inner join klijent d on a.klijent=d.sifra inner join osoba e on d.osoba=e.sifra where a.status=false and a.sifra=:sifra");
	$izraz->bindParam("sifra",$_GET["sifra"]);
	$izraz -> execute();
	$narudzba = $izraz -> fetchAll(PDO::FETCH_OBJ);
	
	if($narudzba==null){
	$izraz = $veza -> prepare("select a.sifra,a.datumnarudzbe,a.termin,a.dan,a.status,a.napomena,a.datumunosa, b.ime as imePsa,c.naziv as nazivPasmine,e.ime as imeKlijenta, e.prezime as prezimeKlijenta from narudzba a inner join pas b on a.pas=b.sifra inner join pasmina c on b.pasmina=c.sifra inner join klijent d on a.klijent=d.sifra inner join osoba e on d.osoba=e.sifra where a.status=true and a.sifra=:sifra");
	$izraz->bindParam("sifra",$_GET["sifra"]);
	$izraz -> execute();
	$narudzba = $izraz -> fetchAll(PDO::FETCH_OBJ);
	}
			
	?>
	
	<div class="row">
		<div class="large-6 columns">
			
				<table class="reference" style="width: 100%">
<tbody>
		
			
			<?php foreach ($narudzba as $n): ?>
			<tr>
			<td><b>Šifra narudžbe:</b></td><td> <?php echo $n->sifra; ?></td>
			</tr>
			<tr>
			<td><b>Klijent:</b></td><td> <?php echo $n->imeKlijenta . " " . $n->prezimeKlijenta ; ?></td>
			</tr>
			<tr>
			<td><b>Pas:</b></td><td> <?php echo $n->imePsa ; ?></td>
			</tr>
			<tr>
			<td><b>Pasmina:</b></td><td> <?php echo $n->nazivPasmine ; ?></td>		
			<?php $date = date_create($n -> datumnarudzbe); ?>			
			</tr>
			<tr>
			<td><b>Datum:</b></td><td> <?php echo date_format($date, 'd.m.Y.'); ?></td>
			</tr>
			<tr>
			<td><b>Dan:</b></td><td> <?php echo $n->dan ; ?></td>
			</tr>
			<tr>
			<td><b>Termin:</b></td><td> <?php echo $n->termin ." h" ; ?></td>
			</tr>
			<tr>
			<td><b>Napomena:</b></td><td> <?php echo $n->napomena ; ?></td>
			</tr>
			<?php endforeach ?>
			

</tbody>
</table>			
		</div>
		
		<div class="large-6 columns">
			<table class="reference" style="width: 100%">
<tbody>
<tr>
	<th>Odabrane usluge</th>
	<th>Cijena (HRK)</th>


</tr>
<?php foreach ($usluga as $u): ?>
					

<tr>
	<td>
	 
	 <!--
	 <input type="checkbox" name="usluga[]" <?php foreach ($narudzba_usluga as $nu){if($u->sifra==$nu->sifraUsluge) echo 'checked="checked"'; }?> /> <?php echo $u->naziv; ?><br> 
	--> 
   
	<?php echo $u->naziv; ?>
	 
   
	
	</td>
	<td><?php foreach ($narudzba_usluga as $nu){
		if($u->sifra==$nu->sifraUsluge){
			if($nu->cijena=="" || $nu->cijena=="0.00"){
				echo "?";
			}else{
				echo $nu->cijena; 
			}
		} 
			}
		?>
		</td>

</tr>

<?php endforeach ?>
<tr>
	<td><b>Ukupno:</b></td>
	<td>
	<?php
	
	$izraz = $veza -> prepare("select sum(cijena) as ukupno from narudzba_usluga where narudzba=:sifra");
	$izraz->bindParam("sifra",$_GET["sifra"]);
	$izraz -> execute();
	$ukupno = $izraz -> fetchColumn();
	
	if($ukupno=="" || $ukupno=="0.00"){
		echo "?";
	}else{
		echo $ukupno;
	}
	
	
	
	?>	
		
		
		
		
	</td>

</tr>
</tbody>
</table>
			
		</div>
	</div>
	
	
	
	
	


	