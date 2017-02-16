$(document).ready(function() {
    $.getJSON('./db.json',
        function(json) {
            var i = 0;
            $.each(json.keys, function(index, value) {
                if (i > 0) {
                    if (value.enabled == 1) {
                        status = "Enabled";
                        $('tbody').append('<tr><th class="time">' + status + '</th><th>' + value.username + '</th>\
                        <th><form action="view.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">View</button></form></th>\
                        <th><form action="disable.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">Disable</button></form></th>\
                        <th><form action="delete.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">Delete</button></form></th></tr>');
                    } else {
                        status = "Disabled";
                        $('tbody').append('<tr><th class="time">' + status + '</th><th>' + value.username + '</th>\
                        <th><form action="view.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">View</button></form></th>\
                        <th><form action="enable.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">Enable</button></form></th>\
                        <th><form action="delete.php" method="get"><input type="hidden" name="id" value=' + i + '><button type="submit">Delete</button></form></th></tr>');
                    }
                }
                i++;
            });
        }
    )
});