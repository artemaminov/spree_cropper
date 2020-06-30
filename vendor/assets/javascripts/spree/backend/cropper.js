let Croom = function() {
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

Croom.prototype.initTargets = function() {
    for (let target of this.devices) {
        $('#targets').append(`<div id="target-${this.getDeviceName(target)}"></div>`);
        this.canvasCopy(target);
        this.initCrop(target);
    }
}

Croom.prototype.initCrop = function(target) {
    $('#previews').append(`<div id="preview-${this.getDeviceName(target)}"></div>`);
    let dimensions = this.getDevice(target).dimensions;
    console.log(dimensions);
    $(`#${this.getDeviceName(target)}-canvas`).rcrop({
        minSize: [dimensions.width, dimensions.height],
        preserveAspectRatio: true,
        inputs: true,
        preview: {
            display: true,
            size: [dimensions.width, dimensions.height],
            wrapper: `#preview-${this.getDeviceName(target)}`,
            inputs: true
        }
    });
}

Croom.prototype.getDeviceName = function(device) {
    return Object.keys(device)[0];
}

Croom.prototype.getDevice = function(target) {
    return target[this.getDeviceName(target)];
}

Croom.prototype.canvasCopy = function(target) {
    let source = document.getElementById(`source`);
    let deviceName = this.getDeviceName(target);
    let canvasesContainer = document.getElementById(`target-${deviceName}`);
    let canvas = source.cloneNode();
    canvas.id = `${deviceName}-canvas`;
    canvasesContainer.appendChild(canvas);
}

Croom.prototype.getCoords = function(target) {
    return $(`#${this.getDeviceName(target)}-canvas`).rcrop('getValues');
}

$(function() {
    let croom = new Croom();
    croom.initTargets();
    $('#values').click(function() {
        let text = '';
        let coords = {};
        for (let target of croom.devices) {
            coords = croom.getCoords(target);
            text += `${croom.getDeviceName(target) }: ${ coords.width }x${ coords.height }+${ coords.x }+${ coords.y } | `;
            croom.getDevice(target).coords = coords;
        }
        $('#results').text(`${text}`);
        console.log(JSON.stringify(croom.devices));
    });
});