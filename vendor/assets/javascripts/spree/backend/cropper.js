let Cropper = function() {
    this.devices = [
        {
            name: 'desktop',
            coords: {},
            dimensions: {
                width: 1024,
                height: 400
            }
        },
        {
            name: 'tablet_landscape',
            coords: {},
            dimensions: {
                width: 600,
                height: 300
            }
        },
        {
            name: 'tablet_portrait',
            coords: {},
            dimensions: {
                width: 300,
                height: 600
            }
        },
        {
            name: 'mobile',
            coords: {},
            dimensions: {
                width: 200,
                height: 400
            }
        },
    ];
}

Cropper.prototype.initTargets = function() {
    for (let target of this.devices) {
        $('#targets').append(`<div id="target-${target.name}"></div>`);
        this.canvasCopy(target);
        this.initCrop(target);
    }
}

Cropper.prototype.initCrop = function(target) {
    $('#previews').append(`<div id="preview-${target.name}"></div>`);
    let dimensions = target.dimensions;
    console.log(dimensions);
    $(`#${target.name}-canvas`).rcrop({
        minSize: [dimensions.width, dimensions.height],
        preserveAspectRatio: true,
        grid: true,
        inputs: true,
        preview: {
            display: true,
            size: [dimensions.width, dimensions.height],
            wrapper: `#preview-${target.name}`,
            inputs: true
        }
    });
}

Cropper.prototype.getDeviceName = function(device) {
    return Object.keys(device)[0];
}

Cropper.prototype.getDevice = function(target) {
    return target[target.name];
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
        let text = '';
        let coords = {};
        for (let target of cropper.devices) {
            coords = cropper.getCoords(target);
            text += `${ target.name }: ${ coords.width }x${ coords.height }+${ coords.x }+${ coords.y }`;
            Object.assign(target, coords);

            $(`#${ target.name }_cropper`).val(JSON.stringify(target));
        }
        $('#results').text(`${text}`);
        $('#cropper_dimensions').val(JSON.stringify(cropper.devices));
    });
});