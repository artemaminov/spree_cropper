let Cropper = function() {
    this.devices = [];
}

Cropper.prototype.initTargets = function() {
    this.collectData();
    for (let target of this.devices) {
        $('#targets').append(`<div id="target-${target.name}"></div>`);
        this.canvasCopy(target);
        this.initCrop(target);
    }
}

Cropper.prototype.collectData = function() {
    let dataDevices = $('#source').data("devices");
    let targetCoords = {};
    let device = {};
    let devicesNames = Object.keys(dataDevices);
    for (let targetName of devicesNames) {
        device = {};
        targetCoords = {};
        device.name = targetName;
        device.dimensions = dataDevices[targetName];
        targetCoords.width = $(`#${targetName}_cropper_width`).val();
        targetCoords.height = $(`#${targetName}_cropper_height`).val();
        targetCoords.x = $(`#${targetName}_cropper_x`).val();
        targetCoords.y = $(`#${targetName}_cropper_y`).val();
        device.coords = targetCoords;
        this.devices.push(device);
    }
}

Cropper.prototype.initCrop = function(target) {
    $('#previews').append(`<div id="preview-${target.name}"></div>`);
    let dimensions = target.dimensions;
    $(`#${target.name}-canvas`)
        .rcrop({
            minSize: [dimensions.width, dimensions.height],
            preserveAspectRatio: true,
            grid: true,
            inputs: true,
            preview: {
                display: true,
                size: [dimensions.width, dimensions.height],
                wrapper: `#preview-${target.name}`,
            }
        })
        .on('rcrop-ready', {object: this, target: target}, function(event) {
            event.data.object.applyData(event.data.target.name, event.data.target.coords);
        });
}

Cropper.prototype.applyData = function(targetName, dimensions) {
    $(`#${targetName}-canvas`).rcrop('resize', dimensions.width, dimensions.height, dimensions.x, dimensions.y);
}

Cropper.prototype.canvasCopy = function(target) {
    let source = document.getElementById(`source`);
    let canvasesContainer = document.getElementById(`target-${target.name}`);
    let canvas = source.cloneNode();
    canvas.id = `${target.name}-canvas`;
    canvasesContainer.appendChild(canvas);
}

Cropper.prototype.getCoords = function(target) {
    return $(`#${target.name}-canvas`).rcrop('getValues');
}

$(function() {
    let cropper = new Cropper();
    cropper.initTargets();
    $('#values').click(function() {
        let coords = {};
        for (let target of cropper.devices) {
            coords = cropper.getCoords(target);
            $(`#${ target.name }_cropper_x`).val(coords.x);
            $(`#${ target.name }_cropper_y`).val(coords.y);
            $(`#${ target.name }_cropper_width`).val(coords.width);
            $(`#${ target.name }_cropper_height`).val(coords.height);
            $(`#${ target.name }_cropper_name`).val(target.name);
        }
    });
});
