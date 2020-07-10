class Cropper {
    devices = [];

    constructor() {
        this.collectData();
        this.initTargets();
    }

    bindAutoFillInputs(target) {
        $(`#${target.name}-canvas`).on('rcrop-changed rcrop-ready', event => this.fill(event, target));
    }

    fill(event, target) {
        let coords = this.getCoords(target);
        $(`#${ target.name }_cropper_x`).val(coords.x);
        $(`#${ target.name }_cropper_y`).val(coords.y);
        $(`#${ target.name }_cropper_width`).val(coords.width);
        $(`#${ target.name }_cropper_height`).val(coords.height);
        $(`#${ target.name }_cropper_name`).val(target.name);
    }

    initTargets() {
        for (let target of this.devices) {
            $('#targets').append(`<div id="target-${target.name}"></div>`);
            this.canvasCopy(target);
            this.initCrop(target);
            this.bindAutoFillInputs(target);
        }
    }

    collectData() {
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

    initCrop(target) {
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
            .on('rcrop-ready', event => this.applyData(event, target));
    }

    applyData(event, target) {
        let dimensions = target.coords;
        $(`#${target.name}-canvas`).rcrop('resize', dimensions.width, dimensions.height, dimensions.x, dimensions.y);
    }

    canvasCopy(target) {
        let source = document.getElementById(`source`);
        let canvasesContainer = document.getElementById(`target-${target.name}`);
        let canvas = source.cloneNode();
        canvas.id = `${target.name}-canvas`;
        canvasesContainer.appendChild(canvas);
    }

    getCoords(target) {
        let coords = $(`#${target.name}-canvas`).rcrop('getValues');
        return coords;
    }
}

$(function() {
    new Cropper();
});
