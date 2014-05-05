$(document).ready(function(){
    $('#rate').one('click', function(event) {
        $.ajax({
            url: $(this).attr('ajax_path'),
            type: "POST",
            data: { },
            dataType: "script",
            async: true,
            success: function(response){
                console.log("Success!");
                // response contains new rating, print it somewhere?
                $('#current-rating').html(response);
            }
        });
    });
});
