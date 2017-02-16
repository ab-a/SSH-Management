$(document).ready(function() {
    $.getJSON('./db.json',
        function(json) {
            var i = 0;
            $.each(json.keys, function(index, value) {
                if (i > 0) {
                    if (value.enabled == 1) {
                        status = "Enabled";
                    } else {
                        status = "Disabled";
                    }
                    $('tbody').append('<tr><th class="time">' + status + '</th><th>' + value.username + '</th>');
                }
                console.log(i);
                i++;
            });
        }
    )
});
