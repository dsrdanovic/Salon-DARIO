<script src="<?php echo $putanjaApp; ?>js/vendor/jquery.js"></script>
<script src="<?php echo $putanjaApp; ?>js/foundation.min.js"></script>
<script>$(document).foundation();</script>
<script src="<?php echo $putanjaApp; ?>tooltipster/js/jquery.tooltipster.min.js"></script>
<script src="<?php echo $putanjaApp; ?>js/vendor/jquery-ui.js"></script>

<script>
$('#vrh').on("click",function() {
    $('html, body').animate({ scrollTop: 0 }, 'slow', function () {
    });
});
</script>