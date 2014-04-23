$(document).ready(function(){
    $( "#show-filters" ).click(function() {
        $( "#filters" ).slideToggle( "slow", "swing", function() {
        // Animation complete.
        });
    });
});
