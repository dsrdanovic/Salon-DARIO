<?php
include_once '../../konfiguracija.php';


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
				
				<h4><i class="fi-graph-bar"> </i>Statistike</h4>
				<hr />
			
					<div id="container" style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>
				
			</div>
		</div>
		<br />
		<br />
		
		
		
	
		<?php
		include_once '../../podnozje.php';
		?>

		<?php
		include_once '../../skripte.php';
		?>
		
		<script src="http://code.highcharts.com/highcharts.js"></script>
		<script src="http://code.highcharts.com/modules/exporting.js"></script>
		<script>
			$(function(){
				
				$(function () {
    $('#container').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Postotak pasa po pasminama'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                    }
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Udio',
            data: [
            <?php 
            
            $izraz = $veza -> prepare("select b.naziv, count(b.naziv) as ukupno from pas a inner join pasmina b on a.pasmina=b.sifra group by pasmina");
			$izraz -> execute();
			$rezultati = $izraz -> fetchAll(PDO::FETCH_OBJ);
			foreach ($rezultati as $o) :
				echo " ['" .  $o->naziv . "',   " . $o->ukupno .  "],";
				endforeach;
            
            ?>
            
            ]
        }]
    });
});


				
			});
			
		</script>

	</body>
</html>
