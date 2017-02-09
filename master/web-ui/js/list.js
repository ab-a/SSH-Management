$(document).ready(function() {
    $.getJSON('./db.json',
        function(json) {
            $.each(json.keys, function(index, value) {
                if (value.enabled == 1) {
                    status = "Enabled";
                } else {
                    status = "Disabled";
                }
                $('tbody').append('<tr><th class="time">' + status + '</th><th>' + value.username + '</th>');
            });
        }
    )
});
