let devices = [
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

let initTargets = function() {
    for (let target of devices) {
        $('#targets').append(`<div id="target-${getDeviceName(target)}"></div>`);
        canvasCopy(target);
        initCrop(target);
    }
}

let initCrop = function(target) {
    $('#previews').append(`<div id="preview-${getDeviceName(target)}"></div>`);
    let dimensions = getDevice(target).dimensions;
    console.log(dimensions);
    $(`#${getDeviceName(target)}-canvas`).rcrop({
        minSize: [dimensions.width, dimensions.height],
        preserveAspectRatio: true,
        inputs: true,
        preview: {
            display: true,
            size: [dimensions.width, dimensions.height],
            wrapper: `#preview-${getDeviceName(target)}`,
            inputs: true
        }
    });
}

let getDeviceName = function(device) {
    return Object.keys(device)[0];
}

let getDevice = function(target) {
    return target[getDeviceName(target)];
}

let canvasCopy = function(target) {
    let source = document.getElementById(`source`);
    let deviceName = getDeviceName(target);
    let canvasesContainer = document.getElementById(`target-${deviceName}`);
    let canvas = source.cloneNode();
    canvas.id = `${deviceName}-canvas`;
    canvasesContainer.appendChild(canvas);
}

let getCoords = function(target) {
    return $(`#${getDeviceName(target)}-canvas`).rcrop('getValues');
}

$('#values').click(function() {
    let text = '';
    let coords = {};
    for (let target of devices) {
        coords = getCoords(target);
        text += `${ getDeviceName(target) }: ${ coords.width }x${ coords.height }+${ coords.x }+${ coords.y } | `;
        getDevice(target).coords = coords;
    }
    $('#results').text(`${text}`);
    console.log(JSON.stringify(devices));
});

$(function() {
    initTargets();
});