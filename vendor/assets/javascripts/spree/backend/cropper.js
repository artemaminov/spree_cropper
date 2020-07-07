let Cropper = function() {
    this.devices = [
        {
            desktop: {
                coords: {},
                dimensions: {
                    width: 1024,
                    height: 400
                }
            }
        },
        {
            tablet_land: {
                coords: {},
                dimensions: {
                    width: 600,
                    height: 300
                }
            }
        },
        {
            tablet_port: {
                coords: {},
                dimensions: {
                    width: 300,
                    height: 600
                }
            }
        },
        {
            mobile: {
                coords: {},
                dimensions: {
                    width: 200,
                    height: 400
                }
            }
        },
    ];
}

Cropper.prototype.initTargets = function() {
    for (let target of this.devices) {
        $('#targets').append(`<div id="target-${this.getDeviceName(target)}"></div>`);
        this.canvasCopy(target);
        this.initCrop(target);
    }
}

Cropper.prototype.initCrop = function(target) {
    $('#previews').append(`<div id="preview-${this.getDeviceName(target)}"></div>`);
    let dimensions = this.getDevice(target).dimensions;
    console.log(dimensions);
    $(`#${this.getDeviceName(target)}-canvas`).rcrop({
        minSize: [dimensions.width, dimensions.height],
        preserveAspectRatio: true,
        grid: true,
        inputs: true,
        preview: {
            display: true,
            size: [dimensions.width, dimensions.height],
            wrapper: `#preview-${this.getDeviceName(target)}`,
            inputs: true
        }
    });
}

Cropper.prototype.getDeviceName = function(device) {
    return Object.keys(device)[0];
}

Cropper.prototype.getDevice = function(target) {
    return target[this.getDeviceName(target)];
}

Cropper.prototype.canvasCopy = function(target) {
    let source = document.getElementById(`source`);
    let deviceName = this.getDeviceName(target);
    let canvasesContainer = document.getElementById(`target-${deviceName}`);
    let canvas = source.cloneNode();
    canvas.id = `${deviceName}-canvas`;
    canvasesContainer.appendChild(canvas);
}

Cropper.prototype.getCoords = function(target) {
    return $(`#${this.getDeviceName(target)}-canvas`).rcrop('getValues');
}

$(function() {
    let cropper = new Cropper();
    cropper.initTargets();
    $('#values').click(function() {
        let text = '';
        let coords = {};
        for (let target of cropper.devices) {
            coords = cropper.getCoords(target);
            text += `${cropper.getDeviceName(target) }: ${ coords.width }x${ coords.height }+${ coords.x }+${ coords.y } | `;
            cropper.getDevice(target).coords = coords;
        }
        $('#results').text(`${text}`);
        console.log(JSON.stringify(cropper.devices));
    });
});