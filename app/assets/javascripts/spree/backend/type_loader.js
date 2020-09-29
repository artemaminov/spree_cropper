$(function() {
    $('#select2-boundary_type_id').on('change', function (e) {
        let type = $('#select2-boundary_type_id').select2('data');
        let imageCombineId = $('#source').data('id');
        $('#cropper-tabs-content').hide();
        $.ajax({
            url: `/admin/image_combines/${imageCombineId}/edit`,
            method: "GET",
            type: "json",
            data: {
                'type_id': type.id,
            },
            // error: function (xhr, status, error) {
            //     console.error('AJAX Error: ' + status + error);
            // },
            success: function (response) {
                Cropper.destroyAll();
                let data_str = JSON.stringify(response);
                $('#source').attr('data-dimensions', data_str);
                let i = 0;
                for (let newDimension in response) {
                    window.cropper.croppers[i].dimensions = response[i+1];
                    // console.log(window.cropper.croppers[i].dimensions, response[i+1]);
                    i++;
                }
                $('#cropper-tabs-content').show();
            }
        })
    });
});
