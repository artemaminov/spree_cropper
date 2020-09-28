$(function() {
    $('#select2-boundary_type_id').on('change', function (e) {
        let type = $('#select2-boundary_type_id').select2('data');
        let imageCombineId = $('#source').data('id');
        $.ajax({
            url: `/admin/image_combines/${imageCombineId}/edit`,
            method: "GET",
            // type: "js",
            data: {
                'type_id': type.id,
            },
            // error: function (xhr, status, error) {
            //     console.error('AJAX Error: ' + status + error);
            // },
            // success: function (response) {
            //     console.log(response["records"]);
            // }
        })
            .done(function( html ) {
                alert('ok');
            });
    });
});
